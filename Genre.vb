Imports System.IO
Imports MySql.Data.MySqlClient

Public Class Genre
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
        End With
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        With Me
            Call Connect_to_DB()
            Dim mycmd As New MySqlCommand
            Try
                strSQL = "Insert into genre (genre_id, genre_type)
                value('" _
                & .TextBox1.Text & "', '" _
                & .TextBox2.Text & "')"
                mycmd.CommandText = strSQL
                mycmd.Connection = myconn
                mycmd.ExecuteNonQuery()
                MsgBox("Genre Successfully Added", MsgBoxStyle.Information)
                Call Clear_Boxes()
            Catch ex As MySqlException
                MsgBox(ex.Number & " " & ex.Message)
            End Try
            Call Disconnect_to_DB()
        End With
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim genreID As Integer = Integer.Parse(TextBox1.Text)
        Dim genre As String = TextBox2.Text
        Dim result As DialogResult = MessageBox.Show("Are you sure you want to Delete this Record?", "Confirm Deletion", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)
        If result = DialogResult.Yes Then
            Try
                Call Connect_to_DB()
                Dim query As String = "Delete from genre where genre_id = @genre_id AND genre_type = @genre_type"
                Dim mycmd As New MySqlCommand(query, myconn)
                mycmd.Parameters.AddWithValue("@genre_id", genreID)
                mycmd.Parameters.AddWithValue("@genre_type", genre)
                Dim rowsDeleted As Integer = mycmd.ExecuteNonQuery()
                If rowsDeleted > 0 Then
                    MsgBox("Genre Successfully Deleted")
                    Call Clear_Boxes()
                Else
                    MsgBox("No Matching Record Found")
                End If
            Catch ex As MySqlException
                MsgBox("Error deleting record: " & ex.Message)
            Finally
                Call Disconnect_to_DB()
            End Try
        End If
    End Sub

    Private Sub Display_Click(sender As Object, e As EventArgs) Handles Display.Click
        Me.DataGridView1.Rows.Clear()
        Dim strsql As String
        Dim mycmd As New MySqlCommand
        strsql = "Select * from genre"
        Call Connect_to_DB()
        With mycmd
            .Connection = myconn
            .CommandType = CommandType.Text
            .CommandText = strsql
        End With
        Dim myreader As MySqlDataReader
        myreader = mycmd.ExecuteReader
        While myreader.Read()
            Me.DataGridView1.Rows.Add(New Object() {myreader.Item("genre_id"), myreader.Item("genre_type")})
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
                    Dim insertSql As String = "Insert into genre ("
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
        Call ExportToExcel(Me.DataGridView1, "GenreTemp.xlsx")
    End Sub
End Class