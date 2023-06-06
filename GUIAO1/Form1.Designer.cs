﻿using System;
using System.Data;
using System.Data.SqlClient;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Xml.Linq;

namespace GUIAO1
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            button1 = new Button();
            button2 = new Button();
            SuspendLayout();
            // 
            // button1
            // 
            button1.ForeColor = Color.Black;
            button1.Location = new Point(98, 115);
            button1.Margin = new Padding(3, 2, 3, 2);
            button1.Name = "button1";
            button1.Size = new Size(179, 50);
            button1.TabIndex = 0;
            button1.Text = "Motorista";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // button2
            // 
            button2.Location = new Point(410, 115);
            button2.Margin = new Padding(3, 2, 3, 2);
            button2.Name = "button2";
            button2.Size = new Size(192, 50);
            button2.TabIndex = 4;
            button2.Text = "Cliente";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(700, 338);
            Controls.Add(button2);
            Controls.Add(button1);
            Margin = new Padding(3, 2, 3, 2);
            Name = "Form1";
            Text = "Aula 1 BD";
            Load += Form1_Load;
            ResumeLayout(false);
        }

        #endregion
        private void TestDBConnection(string dbServer, string dbName, string userName, string userPass)
        {
            SqlConnection CN = new SqlConnection("Data Source = " + dbServer + " ;" + "Initial Catalog = " + dbName +
                                                       "; uid = " + userName + ";" + "password = " + userPass);

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    MessageBox.Show("Successful connection to database " + CN.Database + " on the " + CN.DataSource + " server", "Connection Test", MessageBoxButtons.OK);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" + ex.Message, "Connection Test", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();
        }


        

        private List<Motorista> getMotoristasContent(SqlConnection CN)
        {
            List<Motorista> motoraList = new List<Motorista>();

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    
                    SqlCommand sqlcmd = new SqlCommand("EXEC listMotoristas", CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();
                    
                    while (reader.Read())
                    {
                        Motorista M = new Motorista();
                        M.MotoristaID = reader.GetInt32(reader.GetOrdinal("id")).ToString();
                        M.MotoristaNome = reader.GetString(reader.GetOrdinal("nome")) ;
                        M.MotoristaEmail = reader.GetString(reader.GetOrdinal("email"));
                        M.MotoristaFoto = reader.GetString(reader.GetOrdinal("foto"));
                        M.MotoristaAvaliacao = reader.GetDouble(reader.GetOrdinal("avaliacao")).ToString();
                        M.MotoristaTelefone = reader.GetInt32(reader.GetOrdinal("telefone")).ToString();
                        M.MotoristaCartaConducao = reader.GetString(reader.GetOrdinal("carta_conducao"));
                        motoraList.Add(M);
                        
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();
            return motoraList;
        }

        private List<Cliente> getClientesContent(SqlConnection CN)
        {
            List<Cliente> clientesList = new List<Cliente>();

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    
                    SqlCommand sqlcmd = new SqlCommand("EXEC listClientes", CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();
                    
                    while (reader.Read())
                    {
                        Cliente C = new Cliente();
                        C.ClienteID = reader.GetInt32(reader.GetOrdinal("id")).ToString();
                        C.ClienteNome = reader.GetString(reader.GetOrdinal("nome")) ;
                        C.ClienteEmail = reader.GetString(reader.GetOrdinal("email"));
                        C.ClienteFoto = reader.GetString(reader.GetOrdinal("foto"));
                        C.ClienteAvaliacao = reader.GetDouble(reader.GetOrdinal("avaliacao")).ToString();
                        C.ClienteTelefone = reader.GetInt32(reader.GetOrdinal("telefone")).ToString();
                        clientesList.Add(C);
                        
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open conne'ction to database due to the error \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();
            return clientesList;
        }
        

        private SqlConnection getConnection()
        {
            SqlConnection CN = new SqlConnection(Properties.Settings.Default.ConnectionString);

            return CN;
        }

        private Button button1;
        private TextBox textBox1;
        private TextBox textBox2;
        private TextBox textBox3;
        private Button button2;
        private Label label1;
        private Label label2;
        private Label label3;


    }
}