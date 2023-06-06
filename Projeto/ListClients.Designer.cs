using System.Data.SqlClient;
using System.Data;

namespace GUIAO1
{
    partial class ListClients
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            listBox1 = new ListBox();
            panel2 = new Panel();
            clienteEditButton = new Button();
            textBox3 = new TextBox();
            textBox4 = new TextBox();
            label3 = new Label();
            label4 = new Label();
            textBox2 = new TextBox();
            label2 = new Label();
            textBox1 = new TextBox();
            label1 = new Label();
            button1 = new Button();
            clienteAddButton = new Button();
            clienteCancelButton = new Button();
            clienteOkButton = new Button();
            clientesPrecoCorridas = new Button();
            panel2.SuspendLayout();
            SuspendLayout();
            // 
            // listBox1
            // 
            listBox1.FormattingEnabled = true;
            listBox1.ItemHeight = 15;
            listBox1.Location = new Point(12, 13);
            listBox1.Name = "listBox1";
            listBox1.Size = new Size(279, 394);
            listBox1.TabIndex = 0;
            listBox1.SelectedIndexChanged += listBox1_SelectedIndexChanged;
            // 
            // panel2
            // 
            panel2.BackColor = SystemColors.ActiveBorder;
            panel2.Controls.Add(clienteEditButton);
            panel2.Controls.Add(textBox3);
            panel2.Controls.Add(textBox4);
            panel2.Controls.Add(label3);
            panel2.Controls.Add(label4);
            panel2.Controls.Add(textBox2);
            panel2.Controls.Add(label2);
            panel2.Controls.Add(textBox1);
            panel2.Controls.Add(label1);
            panel2.Location = new Point(297, 13);
            panel2.Name = "panel2";
            panel2.Size = new Size(491, 167);
            panel2.TabIndex = 2;
            panel2.Paint += panel2_Paint;
            // 
            // clienteEditButton
            // 
            clienteEditButton.Location = new Point(366, 118);
            clienteEditButton.Name = "clienteEditButton";
            clienteEditButton.Size = new Size(95, 36);
            clienteEditButton.TabIndex = 8;
            clienteEditButton.Text = "Edit";
            clienteEditButton.UseVisualStyleBackColor = true;
            clienteEditButton.Click += clienteEditButton_Click;
            // 
            // textBox3
            // 
            textBox3.Location = new Point(17, 76);
            textBox3.Name = "textBox3";
            textBox3.Size = new Size(50, 23);
            textBox3.TabIndex = 6;
            textBox3.TextChanged += textBox3_TextChanged;
            // 
            // textBox4
            // 
            textBox4.Location = new Point(274, 76);
            textBox4.Name = "textBox4";
            textBox4.Size = new Size(100, 23);
            textBox4.TabIndex = 7;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(17, 58);
            label3.Name = "label3";
            label3.Size = new Size(58, 15);
            label3.TabIndex = 2;
            label3.Text = "Avaliação";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(274, 58);
            label4.Name = "label4";
            label4.Size = new Size(51, 15);
            label4.TabIndex = 3;
            label4.Text = "Telefone";
            label4.Click += label4_Click;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(274, 24);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(187, 23);
            textBox2.TabIndex = 5;
            textBox2.TextChanged += textBox2_TextChanged;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(274, 6);
            label2.Name = "label2";
            label2.Size = new Size(36, 15);
            label2.TabIndex = 1;
            label2.Text = "Email";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(17, 24);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(100, 23);
            textBox1.TabIndex = 4;
            textBox1.TextChanged += textBox1_TextChanged;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(17, 6);
            label1.Name = "label1";
            label1.Size = new Size(40, 15);
            label1.TabIndex = 0;
            label1.Text = "Nome";
            label1.Click += label1_Click_1;
            // 
            // button1
            // 
            button1.Location = new Point(381, 200);
            button1.Name = "button1";
            button1.Size = new Size(107, 36);
            button1.TabIndex = 4;
            button1.Text = "Ver Corridas";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click_1;
            // 
            // clienteAddButton
            // 
            clienteAddButton.Location = new Point(12, 421);
            clienteAddButton.Name = "clienteAddButton";
            clienteAddButton.Size = new Size(95, 36);
            clienteAddButton.TabIndex = 5;
            clienteAddButton.Text = "Add";
            clienteAddButton.UseVisualStyleBackColor = true;
            clienteAddButton.Click += clienteAddButton_Click;
            // 
            // clienteCancelButton
            // 
            clienteCancelButton.Location = new Point(196, 421);
            clienteCancelButton.Name = "clienteCancelButton";
            clienteCancelButton.Size = new Size(95, 36);
            clienteCancelButton.TabIndex = 6;
            clienteCancelButton.Text = "Cancel";
            clienteCancelButton.UseVisualStyleBackColor = true;
            clienteCancelButton.Click += clienteCancelButton_Click;
            // 
            // clienteOkButton
            // 
            clienteOkButton.Location = new Point(12, 421);
            clienteOkButton.Name = "clienteOkButton";
            clienteOkButton.Size = new Size(95, 36);
            clienteOkButton.TabIndex = 7;
            clienteOkButton.Text = "OK";
            clienteOkButton.UseVisualStyleBackColor = true;
            clienteOkButton.Click += clienteOkButton_Click;
            // 
            // clientesPrecoCorridas
            // 
            clientesPrecoCorridas.Location = new Point(558, 200);
            clientesPrecoCorridas.Name = "clientesPrecoCorridas";
            clientesPrecoCorridas.Size = new Size(144, 36);
            clientesPrecoCorridas.TabIndex = 8;
            clientesPrecoCorridas.Text = "Valor Gasto em Corridas";
            clientesPrecoCorridas.UseVisualStyleBackColor = true;
            clientesPrecoCorridas.Click += clientesPrecoCorridas_Click;
            // 
            // ListClients
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 469);
            Controls.Add(clientesPrecoCorridas);
            Controls.Add(clienteOkButton);
            Controls.Add(clienteCancelButton);
            Controls.Add(clienteAddButton);
            Controls.Add(button1);
            Controls.Add(panel2);
            Controls.Add(listBox1);
            Name = "ListClients";
            Text = "ListClients";
            Load += ListClients_Load;
            panel2.ResumeLayout(false);
            panel2.PerformLayout();
            ResumeLayout(false);
        }

        private string getTableContent(SqlConnection CN)
        {
            string str = "";

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    int cnt = 1;
                    SqlCommand sqlcmd = new SqlCommand("SELECT * FROM Pessoas", CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();

                    while (reader.Read())
                    {
                        str += cnt.ToString() + " - " + reader.GetInt32(reader.GetOrdinal("id")) + ", ";
                        str += reader.GetString(reader.GetOrdinal("nome")) + ", ";
                        str += reader.GetString(reader.GetOrdinal("email")) + ", ";
                        str += reader.GetString(reader.GetOrdinal("foto")) + ", ";
                        str += reader.GetInt32(reader.GetOrdinal("avaliacao")) + ", ";
                        str += reader.GetInt32(reader.GetOrdinal("telefone")) + ", ";

                        int cartaConducaoOrdinal = reader.GetOrdinal("carta_conducao");
                        if (!reader.IsDBNull(cartaConducaoOrdinal))
                        {
                            str += reader.GetString(reader.GetOrdinal("carta_conducao")) + ", ";

                        }
                        str += "\n";
                        cnt += 1;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();
            return str;
        }


        #endregion

        private ListBox listBox1;
        private Panel panel2;
        private TextBox textBox3;
        private TextBox textBox4;
        private Label label3;
        private Label label4;
        private TextBox textBox2;
        private Label label2;
        private TextBox textBox1;
        private Label label1;
        private Button button1;
        private Button clienteAddButton;
        private Button clienteCancelButton;
        private Button clienteOkButton;
        private Button clienteEditButton;
        private Button clientesPrecoCorridas;
    }
}