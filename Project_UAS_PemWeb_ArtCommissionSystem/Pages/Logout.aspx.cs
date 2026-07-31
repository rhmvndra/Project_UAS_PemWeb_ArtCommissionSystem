using System;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Bersihkan dan hancurkan semua sesi login yang menempel
            Session.Clear();
            Session.Abandon();

            // 2. Tendang user kembali ke halaman Beranda Publik (Default.aspx)
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}