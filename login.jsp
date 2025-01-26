<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import="java.sql.*, java.util.Random, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.awt.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #ffffff;
        }
        .container {
            width: 100%;
            max-width: 400px;
            background: #1e1e1e;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            border-radius: 8px;
        }
        .login-form h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #ffffff;
            text-align: center;
        }
        .login-form label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #f0f0f0;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #333;
            border-radius: 4px;
            font-size: 14px;
            background-color: #2e2e2e;
            color: #ffffff;
        }
        .login-form input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .login-form input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .captcha-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .captcha-container img {
            border: 1px solid #444;
            border-radius: 4px;
        }
        .captcha-container input {
            flex: 1;
            margin-left: 10px;
            background-color: #2e2e2e;
            color: #ffffff;
            border: 1px solid #333;
        }
        .registration-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
        .registration-link a {
            color: #007bff;
            text-decoration: none;
        }
        .registration-link a:hover {
            text-decoration: underline;
        }
    </style>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    DatabaseConnection db = new DatabaseConnection();
    connection = db.getConnection();

    // Generate a complex CAPTCHA with inclined characters
    if (request.getMethod().equalsIgnoreCase("GET")) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*>?/(),";
        Random random = new Random();
        StringBuilder captchaCode = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            captchaCode.append(characters.charAt(random.nextInt(characters.length())));
        }
        session.setAttribute("captchaCode", captchaCode.toString()); // Store CAPTCHA in session

        // Create CAPTCHA image with inclined characters
        int width = 200, height = 60;
        BufferedImage captchaImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = captchaImage.createGraphics();
        g.setColor(Color.BLACK);
        g.fillRect(0, 0, width, height);

        Font[] fonts = {
            new Font("Serif", Font.BOLD, 24),
            new Font("SansSerif", Font.ITALIC, 26),
            new Font("Monospaced", Font.BOLD, 22),
            new Font("Dialog", Font.PLAIN, 24)
        };
        Color[] colors = {Color.RED, Color.GREEN, Color.BLUE, Color.ORANGE, Color.MAGENTA, Color.CYAN};

        for (int i = 0; i < captchaCode.length(); i++) {
            g.setFont(fonts[random.nextInt(fonts.length)]);
            g.setColor(colors[random.nextInt(colors.length)]);
            int angle = random.nextInt(30) - 15; // Random angle between -15 and 15 degrees
            g.rotate(Math.toRadians(angle), 20 + i * 30, 35);
            g.drawString(String.valueOf(captchaCode.charAt(i)), 20 + i * 30, 35);
            g.rotate(-Math.toRadians(angle), 20 + i * 30, 35);
        }

        g.dispose();

        // Write image to response
        File captchaFile = new File(application.getRealPath("/") + "captcha.png");
        ImageIO.write(captchaImage, "png", captchaFile);
    }
%>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <h2>Login</h2>
            <form name="loginForm" method="POST" onsubmit="return validateLoginForm()">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter Email" required oncopy="return false" onpaste="return false">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter Password" required oncopy="return false" onpaste="return false">

                <label for="captcha">Enter CAPTCHA:</label>
                <div class="captcha-container">
                    <img src="captcha.png" alt="CAPTCHA">
                    <input type="text" id="captcha" name="captcha" placeholder="Enter CAPTCHA" required oncopy="return false" onpaste="return false">
                </div>

                <input type="submit" value="Login">
            </form>
            <p class="registration-link">Don't have an account? <a href="registration.jsp">Register-Up</a></p>
        </div>
        <%
         if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("email");
            String password = request.getParameter("password");
            String enteredCaptcha = request.getParameter("captcha");
            String sessionCaptcha = (String) session.getAttribute("captchaCode");

            // Validate CAPTCHA
            if (enteredCaptcha == null || sessionCaptcha == null || !enteredCaptcha.equals(sessionCaptcha)) {
                out.println("<script>alert('Invalid CAPTCHA. Please try again.');</script>");
                response.sendRedirect("inValidCaptcha.jsp");
                return;
            }

            // Validate email and password
            preparedStatement = connection.prepareStatement("SELECT email, password FROM AdmissionSystem.registration WHERE email = ?");
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();
            if (resultSet != null && resultSet.next()) {
                if (resultSet.getString("password") != null && password.equals(resultSet.getString("password"))) {
                    session.setAttribute("user", username);
                    response.sendRedirect("Crud_op.jsp");
                } else {
                    response.sendRedirect("wrongPassword.jsp");
                }
            } else {
                response.sendRedirect("registration.jsp");
            }
         }
        %>
    </div>
</body>
<script>
function validateLoginForm() {
    var email = document.forms["loginForm"]["email"].value;
    var password = document.forms["loginForm"]["password"].value;
    var captcha = document.forms["loginForm"]["captcha"].value;

    if (email == "") {
        alert("Email must be filled out");
        return false;
    }

    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address");
        return false;
    }

    if (password == "") {
        alert("Password must be filled out");
        return false;
    }

    if (captcha == "") {
        alert("CAPTCHA must be filled out");
        return false;
    }

    return true;
}
</script>
</html>
