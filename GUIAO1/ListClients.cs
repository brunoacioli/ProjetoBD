using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Diagnostics;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace GUIAO1
{
    public partial class ListClients : Form
    {

        private List<Cliente> _clientesList;
        Cliente cliente;
        private SqlConnection _connection;
        private int clientIndex;
        private bool adding;

        public ListClients()
        {
            InitializeComponent();
        }

        public ListClients(List<Cliente> clientesList, SqlConnection cn)
        {
            ClientesList = clientesList;
            Connection = cn;
            InitializeComponent();
            button1.Visible = false;
        }

        public List<Cliente> ClientesList
        {
            get { return _clientesList; }
            set { _clientesList = value; }
        }

        public SqlConnection Connection
        {
            get { return _connection; }
            set { _connection = value; }
        }

        private void ListClients_Load(object sender, EventArgs e)
        {
            button1.Visible = false;

            foreach (Cliente c in ClientesList)
            {
                listBox1.Items.Add(c);
            }

            LockClienteControls();
            clienteOkButton.Visible = false;
            clienteCancelButton.Visible = false;
            button1.Visible = true;
            clientesPrecoCorridas.Enabled = false;


        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            button1.Visible = false;

            if (listBox1.SelectedIndex >= 0)
            {
                clientIndex = listBox1.SelectedIndex;
                showClientes();
                button1.Visible = true;

            }
            clientesPrecoCorridas.Enabled = true;

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        public void showClientes()
        {
            if (listBox1.Items.Count == 0 | clientIndex < 0)
                return;
            cliente = (Cliente)listBox1.SelectedItem;
            textBox1.Text = cliente.ClienteNome;
            textBox2.Text = cliente.ClienteEmail;
            textBox3.Text = cliente.ClienteAvaliacao;
            textBox4.Text = cliente.ClienteTelefone;
        }




        private List<Corrida> getCorridasByClientId(SqlConnection CN, String id)
        {
            List<Corrida> corridasList = new List<Corrida>();

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {

                    SqlCommand sqlcmd = new SqlCommand("EXEC sp_Cliente_Corridas " + id, CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Corrida C = new Corrida();
                        C.id = reader.GetInt32(reader.GetOrdinal("id")).ToString();
                        C.partida = reader.GetString(reader.GetOrdinal("partida"));
                        C.destino = reader.GetString(reader.GetOrdinal("destino"));
                        //C.inicio = reader.GetString(reader.GetOrdinal("inicio"));
                        //C.fim = reader.GetString(reader.GetOrdinal("fim")).ToString();
                        C.duracao = reader.IsDBNull(reader.GetOrdinal("duracao")) ? null : reader.GetString(reader.GetOrdinal("duracao")).ToString();
                        C.pagamento = reader.IsDBNull(reader.GetOrdinal("pagamento")) ? null : reader.GetDecimal(reader.GetOrdinal("pagamento")).ToString().Substring(0, 4);
                        C.gorjeta = reader.IsDBNull(reader.GetOrdinal("gorjeta")) ? null : reader.GetDecimal(reader.GetOrdinal("gorjeta")).ToString().Substring(0, 4);
                        C.id_cliente = reader.GetInt32(reader.GetOrdinal("id_cliente")).ToString();
                        C.id_motorista = reader.GetInt32(reader.GetOrdinal("id_motorista")).ToString();
                        corridasList.Add(C);

                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();
            return corridasList;
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Debug.WriteLine("ALOOOOOOOOOO");
            SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString);
            List<Corrida> corridasList = getCorridasByClientId(connection, cliente.ClienteID);
            Debug.WriteLine("#######");
            Debug.WriteLine(corridasList.Count);

            ListCorridas corridas = new ListCorridas(corridasList, cliente.ClienteID);
            corridas.Show();
        }

        private void clienteAddButton_Click(object sender, EventArgs e)
        {
            clearFields();
            UnlockClienteControls();
            clienteAddButton.Visible = false;
            clienteEditButton.Visible = false;
            clienteOkButton.Visible = true;
            clienteCancelButton.Visible = true;
            listBox1.Enabled = false;
            adding = true;
        }

        private void clienteCancelButton_Click(object sender, EventArgs e)
        {
            clienteOkButton.Visible = false;
            clienteCancelButton.Visible = false;
            clienteAddButton.Visible = true;
            clienteEditButton.Visible = true;


            clearFields();
            LockClienteControls();
            listBox1.Enabled = true;
            adding = false;
        }

        private void clienteOkButton_Click(object sender, EventArgs e)
        {
            try
            {
                createCliente();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            clienteOkButton.Visible = false;
            clienteCancelButton.Visible = false;
            clienteAddButton.Visible = true;
            button1.Visible = true;
            clearFields();
            listBox1.Enabled = true;
        }

        private void clienteEditButton_Click(object sender, EventArgs e)
        {

        }
        public void clearFields()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";

        }

        public void UnlockClienteControls()
        {
            textBox1.ReadOnly = false;
            textBox2.ReadOnly = false;
            textBox3.ReadOnly = false;
            textBox4.ReadOnly = false;

        }

        public void LockClienteControls()
        {
            textBox1.ReadOnly = true;
            textBox2.ReadOnly = true;
            textBox3.ReadOnly = true;
            textBox4.ReadOnly = true;

        }

        public Boolean createCliente()
        {
            Cliente client = new Cliente();
            try
            {
                client.ClienteNome = textBox1.Text;
                client.ClienteEmail = textBox2.Text;
                client.ClienteAvaliacao = textBox3.Text;
                client.ClienteTelefone = textBox4.Text;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }

            if (adding)
            {
                setCliente(getConnection(), client);
                listBox1.Items.Add(client);
            }
            else
            {
                //update motorista
            }

            return true;
        }

        private void setCliente(SqlConnection CN, Cliente cliente)
        {
            CN.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "EXEC insertNewPessoa @nome, @email, @foto, @avaliacao, @telefone, null;";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@nome", cliente.ClienteNome);
            cmd.Parameters.AddWithValue("@email", cliente.ClienteEmail);
            cmd.Parameters.AddWithValue("@foto", cliente.ClienteNome + ".jpg");
            cmd.Parameters.AddWithValue("@avaliacao", cliente.ClienteAvaliacao);
            cmd.Parameters.AddWithValue("@telefone", cliente.ClienteTelefone);

            cmd.Connection = CN;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Failed to update contact in database. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                CN.Close();
            }

        }

        private SqlConnection getConnection()
        {
            SqlConnection CN = new SqlConnection(Properties.Settings.Default.ConnectionString);

            return CN;
        }

        private void clientesPrecoCorridas_Click(object sender, EventArgs e)
        {
            Cliente currentCliente = (Cliente)listBox1.SelectedItem;
            MessageBox.Show("Valor gasto com Corridas: " + getClienteSalario(getConnection(), currentCliente.ClienteID) + "€");
        }

        private string getClienteSalario(SqlConnection CN, String id)
        {
            string salario = "";
            try
            {
                CN.Open();

                if (CN.State == ConnectionState.Open)
                {

                    string query = "DECLARE @salario INT;\r\nexec @salario = Soma_Pagamento_Clientes " + id + ";\r\nSELECT @salario AS salario";
                    SqlCommand sqlcmd = new SqlCommand(query, CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();


                    while (reader.Read())
                    {
                        salario = reader.GetInt32(reader.GetOrdinal("salario")).ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (CN.State == ConnectionState.Open)
                CN.Close();

            return salario;

        }
    }
}
