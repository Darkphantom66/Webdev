<?php
/*
CSCI 366
Randen J. Nolan
3/31/19
Description: This assignment was to create a webpage using css, html, and php.
*/

	// Get movie name
	$movie = $_GET["film"];

	// Open info file
	$file = fopen($movie . "/info.txt", "r");

	// Set variables to be used for the title and movie rating percent
	$fullHeader = fgets($file) . "(" . trim(fgets($file)) . ")";
	$ratingPercent = fgets($file);
	fclose($file);

	// Change big(or top left) icon based on review percentage
	if($ratingPercent >= 60)
	{
		// Sets it to Fresh icon
		$ratingImage = "http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/freshbig.png";
		$ratingId = "Fresh";
	}
	else
	{
		// Sets it to Rotten icon
		$ratingImage = "http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/rottenbig.png";
		$ratingId = "Rotten";
	}

	// (Right) Open overview file and push the lines of text
	$file2 = file($movie . "/overview.txt", FILE_IGNORE_NEW_LINES);
	

	/* (Left) Code for Review's */

	// Set variables to be used in the html for the reviews
	$reviews = glob($movie . "/review*.txt");
	$img = array();
	$name = array();
	$publisher = array();
	$rating = array();
	$txt = array();

	// Fill the arrays with each reviewers info
	for($i = 0; $i < count($reviews); $i++)
	{
		// Opens current review file
		$file3 = fopen($reviews[$i], "r");

		// Push each of the parts of the review into various arrays
		array_push($txt, fgets($file3));
		array_push($rating, fgets($file3));
		array_push($name, fgets($file3));
		array_push($publisher, fgets($file3));
		fclose($file3);

		// Sets the reviewers rating image
		if(strpos($rating[$i], "FRESH") !== FALSE)
			array_push($img, "http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/fresh.gif"); // Sets it to the fresh icon
		else
			array_push($img, "http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/rotten.gif"); // Sets it to the rotten icon
	}

?>

<!DOCTYPE HTML>

<html lang="en">
	<head>
		<title>Rancid Tomatoes</title>

		<meta charset="utf-8" />
		<link href="movie.css" type="text/css" rel="stylesheet" />
		<link rel="icon" type="image/gif" href="http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/rotten.gif" />
		
	</head>
	<body>
		<div id= "banner">
			<img src="http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/banner.png" alt="Rancid Tomatoes"/>
		</div>
			<h1 id="title"><?= $fullHeader; ?></h1>

		<div id= "content">
			<div id= "right">
				<div>
					<img src="<?= $movie;?>/overview.png" alt="general overview" />
				</div>
				<dl>
					<?php
						for($i = 0; $i < count($file2); $i++)
						{  
							$movInfo = explode(":", $file2[$i]);
					?>
							<dt><?= $movInfo[0]; ?> </dt>
							<dd><?= $movInfo[1]; ?></dd>

					<?php 
				  		}	
				  	?>
				</dl>
			</div>
			<div id="left">
				<div id="left-top">
					<img src="<?= $ratingImage; ?>" alt=<?php $ratingId; ?>/>
					<h2 id="rating"> <?= $ratingPercent;?>%</h2>
				</div>
				<div class="column">
					<?php 
				for($i = 0; $i < count($reviews); $i++)
				{ ?>
					<div class="review">
						<p class="commentBox">
							<img src="<?= trim($img[$i]); ?>" alt="<?= $rating[$i]; ?>" />
							<q><?= trim($txt[$i]); ?></q>
						</p>
						<p class="criticBox">
							<img src="http://cs.millersville.edu/~sschwartz/366/HTML_CSS_Lab/Images/critic.gif" alt="Critic" />
							<?= trim($name[$i]); ?> <br />
							<span class="pubName"><?= trim($publisher[$i]); ?> </span>
						</p>
					</div>
				<?php 
					if(round(count($reviews) / 2) == $i + 1)
					{
						?>
						</div>
						<div class="column">
						<?php
					}
				} ?>
				</div>
			</div>
			<div id="bottom">
				<p><?= "(1-" . count($reviews) . ")" . " of " . count($reviews); ?></p>
			</div>
		</div>
		<div id="validators">
			<a href="http://validator.w3.org/check/referer"><img src="http://cs.millersville.edu/~sschwartz/366/Images/w3c-html.png" alt="Valid HTML5" /></a> <br />
			<a href="http://jigsaw.w3.org/css-validator/check/referer"><img src="http://cs.millersville.edu/~sschwartz/366/Images/w3c-css.png" alt="Valid CSS" /></a>
		</div>
	</body>
</html>