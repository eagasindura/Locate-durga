using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace Durga
{
    public partial class Durga : System.Web.UI.Page
    {
        //static string location = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

            //location = hdnlocation1.Text;

        }
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            string Name = txtName.Text;
          
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from Durga_details where Name like '"+ Name + "%'", con);
           
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GrdNames.DataSource = dt;
                GrdNames.DataBind();
            }
        }

        protected void btnAlert_Click(object sender, EventArgs e)
        {
            string str = string.Empty;
            string strname = string.Empty;
            foreach (GridViewRow gvrow in GrdNames.Rows)
            {
                CheckBox chk = (CheckBox)gvrow.FindControl("chkSelect");
                if (chk != null & chk.Checked)
                {
                    //str += "<b>Name :- </b>" + gvrow.Cells[8].Text ;

                    str += "I'm in this Location:-" + hdnlocation.Value;
                    //str += "<br />";
                     System.Net.Mail.MailMessage mailMessage = new System.Net.Mail.MailMessage();
                     mailMessage.To.Add(gvrow.Cells[8].Text);
            mailMessage.From = new MailAddress("sinduraega@gmail.com");
            mailMessage.Subject = "ASP.NET e-mail test";
            mailMessage.Body = "Hello Durga,\n\n Please Help !!\n\n"+str;
            SmtpClient client = new SmtpClient();

            client.Port = 587;
            client.Credentials = new System.Net.NetworkCredential("sinduraega@gmail.com", "naguraiah");
            client.EnableSsl = true;
            client.Host = "smtp.gmail.com";
            client.Send(mailMessage);
                }
            }
           
            lblRecord.Text = "<b>Email sent to Durga </b>" ;
        }
    }
}