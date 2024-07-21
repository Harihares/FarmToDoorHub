<div class="square" style="margin: 90px 150px; background-color: #4747a1;">
    <h1><%= request.getAttribute("branch_count") %></h1>
    <i class="material-icons" style="color: white; font-size: 50px; float: right">apartment</i>
    <div style="color: white; font-size: 23px; font-weight: bold; margin: -10px 20px;">Branch</div>
</div>
<div class="square" style="margin: 90px 400px; background-color: #4747a1;">
    <h1><%= request.getAttribute("product_count") %></h1>
    <i class="material-icons" style="color: white; font-size: 50px; float: right">inventory_2</i>
    <div style="color: white; font-size: 23px; font-weight: bold; margin: -10px 20px;">Products</div>
</div>

<div class="square" style="margin: 90px 650px; background-color: #4747a1;">
    <h1><%= application.getAttribute("loggedInUsersCount") %></h1>
    <i class="material-icons" style="color: white; font-size: 50px; float: right">people</i>
    <div style="color: white; font-size: 23px; font-weight: bold; margin: -10px 20px;">Logged-In Users</div>
</div>
