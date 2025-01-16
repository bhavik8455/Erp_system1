<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.UserPojo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Basic styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fc;
        }

        .container {
            width: 90%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        p {
            color: #777;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: #007BFF;
            color: white;
            padding: 12px 24px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Table styling */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f9f9f9;
            color: #333;
        }

        td {
            background-color: #f4f7fc;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .toggle-btn {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 6px;
        }

        .active {
            background-color: #4CAF50;
            color: white;
        }

        .inactive {
            background-color: #f44336;
            color: white;
        }

        /* Button styling for actions */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .toggle-btn:focus {
            outline: none;
        }
    </style>
    <script>
        // Function to toggle the button style
        function toggleButton(button, mailID, currentState) {
            var form = button.closest('form');
            if (currentState === 'Active') {
                form.action = 'UserManagement'; // Action for deactivate
                button.classList.remove('active');
                button.classList.add('inactive');
                button.innerHTML = 'Deactivate';
                form.querySelector('[name="action"]').value = 'deactivate';
            } else {
                form.action = 'UserManagement'; // Action for activate
                button.classList.remove('inactive');
                button.classList.add('active');
                button.innerHTML = 'Activate';
                form.querySelector('[name="action"]').value = 'activate';
            }
            form.submit();
        }
    </script>
</head>
<body>

    <div class="container">
        <h1>User Management</h1>
        <p>Manage users, view user profiles, and assign roles.</p>

        <!-- View Users Button -->
        <form method="POST" action="UserManagement">
            <button type="submit" class="btn-primary">View Users</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<UserPojo> userList = (List<UserPojo>) request.getAttribute("userList");
                    if (userList != null) {
                        for (UserPojo user : userList) {
                            // Check if the user is active or inactive
                            boolean isActive = !user.getRole().startsWith("Inactive_");
                            String buttonClass = isActive ? "inactive" : "active"; // Initial state for active users is "inactive" for deactivation
                            String buttonLabel = isActive ? "Deactivate" : "Activate"; // Initial label for active users is "Deactivate"
                %>
                    <tr>
                        <td><%= user.getUserID() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getMailID() %></td>
                        <td><%= user.getRole() %></td>
                        <td>
                            <form method="POST" action="UserManagement" style="display: inline;">
                                <input type="hidden" name="mailID" value="<%= user.getMailID() %>">
                                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                                <input type="hidden" name="name" value="<%= user.getName() %>">
                                <input type="hidden" name="role" value="<%= user.getRole() %>">
                                <button type="button" class="toggle-btn <%= buttonClass %>" onclick="toggleButton(this, '<%= user.getMailID() %>', '<%= isActive ? "Active" : "Inactive" %>')">
                                    <%= buttonLabel %>
                                </button>
                                <input type="hidden" name="action" value="<%= isActive ? "deactivate" : "activate" %>">
                            </form>
                        </td>
                    </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
