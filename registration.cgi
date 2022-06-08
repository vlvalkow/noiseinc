#!/usr/bin/ruby

#REGISTRATION FORM PAGE

puts "Content-Type: text/html\n\n"

#html document
puts "<html lang=\"en\">"
	puts "<head>"

	require "./requires/head.rb"

puts "</head>"
puts <<CONTENT

	<body>
		<header>
			<nav class="navbar navbar-default">
				<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="index.cgi">Noice Inc</a>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

						<ul class="nav navbar-nav navbar-right">
							<li><a href="login.cgi">Log in / Register</a></li>
							
						</ul>
					</div><!-- /.navbar-collapse -->
					
				</div><!-- /.container-fluid -->
			</nav>
		</header>
		
		
	
			<div class="page-title">
				<div class="container">
					<div class="row">
						<div class="col-md-12">

							
							<h1>Registration</h1>

						</div>
					</div>
				</div>
			</div>

	<div class="main-content">
<div class="container">
				<div class="row">
					
						<div class="col-md-12">
							<div class="registration">
								<form method="post" action="signup.cgi">
									<label for="username">Username:</label>
									<p><input type="text" name="username" value=""></p>
									<label for="email">Email:</label>
									<p><input type="text" name="email" value=""></p>
									<label for="password">Password:</label>
									<p><input type="password" name="password" value=""></p>
									<p class="submit"><input class="login-btn" type="submit" name="register" value="Register"></p>
								</form>
							</div>
						</div>


				</div>
			</div>
		</div><!-- /.main-content -->
		
		
		<footer>
		
		</footer>
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.js"></script>
	</body>

</html>
CONTENT
