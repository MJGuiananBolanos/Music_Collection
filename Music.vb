Imports System.IO
Imports MySql.Data.MySqlClient

Public Class Music
    Private Sub Bckbtn_Click(sender As Object, e As EventArgs) Handles Bckbtn.Click
        With Me
            Hide()
            Choices.Show()
        End With
    End Sub
    Public Sub Clear_Boxes()
        With Me
            .TextBox1.Text = ""
            .TextBox2.Text = ""
            .TextBox3.Text = ""
            .TextBox4.Text = ""
            .TextBox5.Text = ""
            .TextBox6.Text = ""
            .TextBox7.Text = ""
        End With
    End Sub
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        With Me
            Call Connect_to_DB()
            Dim mycmd As New MySqlCommand
            Try
                strSQL = "Insert into music (music_id, music_title, download_count, artist_id, genre_id, writer_id, producer_id)
                value('" _
                & .TextBox1.Text & "', '" _
                & .TextBox2.Text & "', '" _
                & .TextBox3.Text & "', '" _
                & .TextBox4.Text & "', '" _
                & .TextBox5.Text & "', '" _
                & .TextBox6.Text & "', '" _
                & .TextBox7.Text & "')"
                mycmd.CommandText = strSQL
                mycmd.Connection = myconn
                mycmd.ExecuteNonQuery()
                MsgBox("Successfully Added")
                Call Clear_Boxes()
            Catch ex As MySqlException
                MsgBox(ex.Number & " " & ex.Message)
            End Try
            Call Disconnect_to_DB()
        End With
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim musicID As Integer = Integer.Parse(TextBox1.Text)
        Dim musicName As String = TextBox2.Text
        Dim result As DialogResult = MessageBox.Show("Are you sure you want to Delete this Record?", "Confirm Deletion", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)
        If result = DialogResult.Yes Then
            Try
                Call Connect_to_DB()
                Dim query As String = "Delete from music where music_id = @music_id AND music_title = @music_title"
                Dim mycmd As New MySqlCommand(query, myconn)
                mycmd.Parameters.AddWithValue("@music_id", musicID)
                mycmd.Parameters.AddWithValue("@music_title", musicName)
                Dim rowsDeleted As Integer = mycmd.ExecuteNonQuery()
                If rowsDeleted > 0 Then
                    MessageBox.Show("Record Successfully Deleted")
                    Call Clear_Boxes()
                Else
                    MessageBox.Show("No Matching Record Found")
                End If
            Catch ex As MySqlException
                MessageBox.Show("Error deleting record: " & ex.Message)
            Finally
                Call Disconnect_to_DB()
            End Try
        End If
    End Sub
    Private Sub Display_Click(sender As Object, e As EventArgs) Handles Display.Click
        Me.DataGridView1.Rows.Clear()
        Dim strsql As String
        Dim mycmd As New MySqlCommand
        strsql = "Select * from music"
        Call Connect_to_DB()
        With mycmd
            .Connection = myconn
            .CommandType = CommandType.Text
            .CommandText = strsql
        End With
        Dim myreader As MySqlDataReader
        myreader = mycmd.ExecuteReader
        While myreader.Read()
            Me.DataGridView1.Rows.Add(New Object() {myreader.Item("music_id"), myreader.Item("music_title"), myreader.Item("download_count"), myreader.Item("artist_id"), myreader.Item("genre_id"), myreader.Item("writer_id"), myreader.Item("producer_id")})
        End While
        Call Disconnect_to_DB()
    End Sub

    Private Sub Import_Click(sender As Object, e As EventArgs) Handles Import.Click
        Dim dlg As New OpenFileDialog With {
            .Filter = "CSV Files (*.csv)|*.csv|All Files (*.*)|*.*"
        }
        If dlg.ShowDialog() = DialogResult.OK Then
            'Read the CSV file into a DataTable
            Dim dt As New DataTable()
            Using reader As New StreamReader(dlg.FileName)
                Dim header As Boolean = True
                While Not reader.EndOfStream
                    Dim line As String = reader.ReadLine()
                    Dim values As String() = line.Split(","c)
                    If header Then
                        For Each value As String In values
                            dt.Columns.Add(value)
                        Next
                        header = False
                    Else
                        dt.Rows.Add(values)
                    End If
                End While
            End Using

            'Connect to the MySQL database
            Call Connect_to_DB()
            Using connection As New MySqlConnection(myConnectionString)
                connection.Open()

                'Insert the data into the MySQL table
                For Each row As DataRow In dt.Rows
                    Dim insertSql As String = "Insert into music ("
                    Dim valuesSql As String = "values ("
                    For Each column As DataColumn In dt.Columns
                        insertSql += "`" + column.ColumnName + "`, "
                        valuesSql += "@" + column.ColumnName + ", "
                    Next
                    insertSql = insertSql.TrimEnd(", ".ToCharArray()) + ")"
                    valuesSql = valuesSql.TrimEnd(", ".ToCharArray()) + ")"
                    Dim insertCommand As New MySqlCommand(insertSql + valuesSql, connection)
                    For Each column As DataColumn In dt.Columns
                        insertCommand.Parameters.AddWithValue("@" + column.ColumnName, row(column))
                    Next
                    insertCommand.ExecuteNonQuery()
                Next

                MessageBox.Show("CSV file imported successfully!")
            End Using
        End If
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Call Connect_to_DB()
        Using connection As New MySqlConnection(myConnectionString)
            connection.Open()

            'Select all rows from the table
            Dim selectSql As String = "select * from music"
            Dim selectCommand As New MySqlCommand(selectSql, connection)
            Dim adapter As New MySqlDataAdapter(selectCommand)
            Dim dt As New DataTable()
            adapter.Fill(dt)

            'Prompt the user to choose a location to save the CSV file
            Dim saveFileDialog As New SaveFileDialog()
            saveFileDialog.Filter = "CSV file (*.csv)|*.csv"
            saveFileDialog.Title = "Export CSV file"
            If saveFileDialog.ShowDialog() <> DialogResult.OK Then
                Exit Sub
            End If

            'Write the contents of the DataTable to the CSV file
            Using writer As New StreamWriter(saveFileDialog.FileName)
                'Write the column headers
                For i As Integer = 0 To dt.Columns.Count - 1
                    writer.Write(dt.Columns(i).ColumnName)
                    If i < dt.Columns.Count - 1 Then
                        writer.Write(",")
                    End If
                Next
                writer.WriteLine()

                'Write the data rows
                For Each row As DataRow In dt.Rows
                    For i As Integer = 0 To dt.Columns.Count - 1
                        writer.Write(row(i).ToString())
                        If i < dt.Columns.Count - 1 Then
                            writer.Write(",")
                        End If
                    Next
                    writer.WriteLine()
                Next
            End Using
        End Using

        MessageBox.Show("Export Completed!")
    End Sub

End Class