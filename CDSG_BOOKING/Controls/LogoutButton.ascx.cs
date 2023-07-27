using System;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace CDSG_BOOKING.Controls
{
    public partial class LogoutButton : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (HttpContext.Current.User.Identity.IsAuthenticated)
                //{
                //    btnLogout.Visible = true;
                //}
                //else
                //{
                //    btnLogout.Visible = false;
                //}
                btnLogout.CssClass = "logoutButtonStyle";
                btnLogout.Visible = true;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();

            // Redirect to the login page
            Response.Redirect("Login.aspx");
        }
    }
}
