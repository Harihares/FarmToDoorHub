<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pay.SalesReport" %>
<!DOCTYPE html>
<html>
<head>
<h1>FarmTODoorHub</h1>
    <title>Sales Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: green;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: Green;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        td {
            color: #555;
        }

        td[colspan="4"] {
            text-align: center;
            color: #999;
        }

        @media (max-width: 600px) {
            table, th, td {
                display: block;
                width: 100%;
            }
            th {
                text-align: right;
            }
            tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #ddd;
            }
            td {
                text-align: right;
                padding: 10px;
            }
            td:before {
                content: attr(data-label);
                float: left;
                text-transform: uppercase;
                font-weight: bold;
                color: #333;
            }
        }
    </style>
</head>
<body>
    <h1>Sales Report</h1>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Product Name</th>
            <th>Total Quantity Sold</th>
            <th>Total Revenue</th>
        </tr>
        <% 
            List<SalesReport> salesReports = (List<SalesReport>) request.getAttribute("salesReports");
            if (salesReports != null) {
                for (SalesReport report : salesReports) {
        %>
            <tr>
                <td><%= report.getTransactionDate() %></td>
                <td><%= report.getItemName() %></td>
                <td><%= report.getTotalQuantitySold() %></td>
                <td>RS.<%= report.getTotalRevenue() %></td>
            </tr>
        <% 
                }
            } else {
        %>
            <tr>
                <td colspan="4">No sales data available.</td>
            </tr>
        <% 
            }
        %>
    </table>

<canvas id="myChart" width="400" height="200"></canvas>

<script>
    const labels = [];
    const totalRevenue = [];
    <% 
        if (salesReports != null) {
            for (SalesReport report : salesReports) {
    %>
                labels.push('<%= report.getTransactionDate() %> - <%= report.getItemName() %>');
                totalRevenue.push('<%= report.getTotalRevenue() %>');
    <% 
            }
        }
    %>

    const data = {
        labels: labels,
        datasets: [{
            label: 'Total Revenue',
            backgroundColor: 'Green',
            borderColor: 'rgb(75, 192, 192)',
            borderWidth: 1,
            data: totalRevenue,
        }]
    };

    const config = {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Total Revenue per Item'
                },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                },
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            animation: {
                duration: 2000,
                easing: 'easeInOutBounce'
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Date and Product Name'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Revenue ($)'
                    }
                }
            }
        }
    };

    window.onload = function() {
        const ctx = document.getElementById('myChart').getContext('2d');
        const myChart = new Chart(ctx, config);
    };
</script>
</body>
</html>
