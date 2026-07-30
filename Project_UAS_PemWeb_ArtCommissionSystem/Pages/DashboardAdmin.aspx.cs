using System;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class DashboardAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Proteksi halaman: Jika belum login, tendang kembali ke halaman Login
            if (Session["Username"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            else
            {
                // Menampilkan nama admin yang sedang login
                if (!IsPostBack)
                {
                    lblUsername.Text = Session["Username"].ToString();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Menghapus sesi dan mengembalikan pengguna ke halaman login
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Pages/Login.aspx");
        }
    }
}