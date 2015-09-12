<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Durga.aspx.cs" Inherits="Durga.Durga" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
    .hideGridColumn
    {
        display:none;
    }
 </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

</head>
<body>

    <script type="text/javascript">
        var x = document.getElementById("demo");
        var lat = "";
        var lng = "";
        $(document).ready(function () {
            getLocation();
            //GetAddress();
        });
        
        // for check all checkbox  
        function CheckAll(Checkbox) {
            var GridVwHeaderCheckbox = document.getElementById("<%=GrdNames.ClientID %>");
            for (i = 1; i < GridVwHeaderCheckbox.rows.length; i++) {
                GridVwHeaderCheckbox.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
        }
      
    
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            }
            else { x.innerHTML = "Geolocation is not supported by this browser."; }
        }
      
        function showPosition(position) {
             lat= position.coords.latitude;
             lng = position.coords.longitude;
            latlondata =  position.coords.latitude + "," +position.coords.longitude;
            latlon = "Your Latitude Position is:=" + position.coords.latitude + "," + "Your Longitude Position is:="  +position.coords.longitude;
            var latlng = new google.maps.LatLng(lat, lng);
            var geocoder = geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        //alert("Location: " + results[1].formatted_address);
                        

                        //if (myHidden)//checking whether it is found on DOM, but not necessary
                        //{
                        document.getElementById('hdnlocation1').innerHTML= results[1].formatted_address;
                        document.getElementById('hdnlocation').value = results[1].formatted_address;
                        //}
                    }
                }
            });
           
         

            var img_url = "http://maps.googleapis.com/maps/api/staticmap?center="
      + latlondata + "&zoom=14&size=400x300&sensor=false";
            document.getElementById("mapholder").innerHTML = "<img src='" + img_url + "' />";
        }

        function showError(error) {
            if (error.code == 1) {
                x.innerHTML = "User denied the request for Geolocation."
            }
            else if (err.code == 2) {
                x.innerHTML = "Location information is unavailable."
            }
            else if (err.code == 3) {
                x.innerHTML = "The request to get user location timed out."
            }
            else {
                x.innerHTML = "An unknown error occurred."
            }
        }
</script>
    
    <form id="form1" runat="server">
        <div style="width:1000px;margin:auto;">
        <asp:HiddenField ID="hdnlocation" runat="server" />
       <b>Location :-</b> <asp:Label ID="hdnlocation1" runat="server" ></asp:Label>
        <p id="demo"></p>
            <br />
<div id="mapholder" ></div>
    <div>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>     <asp:Button ID="BtnSearch" runat="server" Text="Search" OnClick="BtnSearch_Click" />
      <br />
        <asp:GridView ID="GrdNames" AutoGenerateColumns="false" CellPadding="5" runat="server">  
                <Columns>  
                    <asp:TemplateField>  
                        <HeaderTemplate>   
                            <asp:CheckBox ID="chkAllSelect" runat="server" onclick="CheckAll(this);" />  
                        </HeaderTemplate>  
                        <ItemTemplate>  
                            <asp:CheckBox ID="chkSelect" runat="server" />  
                        </ItemTemplate>  
                    </asp:TemplateField>  
                    <asp:BoundField HeaderText="EmpId" DataField="Id"  HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn"/>  
                    <asp:BoundField HeaderText="Name" DataField="Name" />  
                    <asp:BoundField HeaderText="City" DataField="City" />  
                    <asp:BoundField HeaderText="Area" DataField="Region" /> 
                    <asp:BoundField HeaderText="Country" DataField="Country" /> 
                    <asp:BoundField HeaderText="Pincode" DataField="Pincode" />
                    <asp:BoundField HeaderText="Phno" DataField="Phno" /> 
                    <asp:BoundField HeaderText="Email" DataField="Email" />    
                </Columns>  
                <HeaderStyle BackColor="#5d5d5d" Font-Bold="true" ForeColor="White" />  
            </asp:GridView>  
        <br />
            <asp:Button ID="btnAlert" Text="Alert" runat="server"  
                Font-Bold="true" OnClick="btnAlert_Click"  /><br /><br />  
  
              
            <asp:Label ID="lblRecord" runat="server" />   
    </div></div>

    </form>
</body>
</html>
