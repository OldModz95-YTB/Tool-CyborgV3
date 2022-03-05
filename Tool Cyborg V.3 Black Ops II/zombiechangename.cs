using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PS3Lib;


namespace Tool_Cyborg_V._3_Black_Ops_II
{
    public partial class zombiechangename : Form
    {

        PS3API PS3 = new PS3API();

        public zombiechangename()
        {
            InitializeComponent();
        }

        private void monoFlat_Button1_Click(object sender, EventArgs e)
        {
            //connexion PS3
            PS3.ChangeAPI(SelectAPI.ControlConsole);
            PS3.ConnectTarget();
            PS3.AttachProcess();
            MessageBox.Show("Vous éte connecter & attacher ;)");
            monoFlat_Button1.Text = "PS3 connecter";
    }

        private void monoFlat_Button27_Click(object sender, EventArgs e)
        {
            byte[] bytes = Encoding.ASCII.GetBytes(this.logInNormalTextBox4.Text);
            Array.Resize<byte>(ref bytes, bytes.Length + 1);
            PS3.SetMemory(24667244u, bytes);
            PS3.SetMemory(24667244u, bytes);
        }

        private void monoFlat_Button2_Click(object sender, EventArgs e)
        {
            byte[] bytes = Encoding.ASCII.GetBytes(this.logInNormalTextBox1.Text);
            Array.Resize<byte>(ref bytes, bytes.Length + 1);
            PS3.SetMemory(24667244u, bytes);
            PS3.SetMemory(24667244u, bytes);
        }

        private void monoFlat_Button4_Click(object sender, EventArgs e)
        {

            byte[] bytes = Encoding.ASCII.GetBytes(this.logInNormalTextBox3.Text);
            Array.Resize<byte>(ref bytes, bytes.Length + 1);
            PS3.SetMemory(24667244u, bytes);
            PS3.SetMemory(24667244u, bytes);
        }

        private void monoFlat_Button3_Click(object sender, EventArgs e)
        {
            byte[] bytes = Encoding.ASCII.GetBytes(this.logInNormalTextBox2.Text);
            Array.Resize<byte>(ref bytes, bytes.Length + 1);
            PS3.SetMemory(24667244u, bytes);
            PS3.SetMemory(24667244u, bytes);
        }
}
}