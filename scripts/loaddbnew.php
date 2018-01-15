<?php
error_reporting(E_ALL);
ini_set ('display_errors', 'On'); 
include("/var/www/html/config.php");
$block = 0;
$vorhanden = 0;
$ergebnis = mysqli_query($db, "SELECT id, routerid, interface FROM allg_info");
while($row = mysqli_fetch_object($ergebnis))
{
	$json = file_get_contents('https://monitoring.freifunk-franken.de/routers/'.$row->routerid.'?json');
	$data = json_decode($json,true);
	$leng = count($data["netifs"]);
	$i = 0;
	while ($i < $leng)
	{
		if($data["netifs"][$i]["netif"] == $row->interface)
		{	
			//Zeit korrigieren
			$zeit = $data["last_contact"]["\$date"]/1000;
			echo "<br /><br />id: ";
			echo $row->id;
			echo "<br />Interface: ";
			echo $row->interface;
			echo "<br />Zeit: ";
			echo $zeit;
			echo "<br />RX Bytes: ";
			echo $data["netifs"][$i]["rx"];
			echo "<br />TX Bytes: ";
			echo $data["netifs"][$i]["tx"];
			//berechne RX:
			$rxtraffic = round($data["netifs"][$i]["rx"])*8;
			echo "<br>RX: $rxtraffic bit / sec<br>";
			//berechne TX:
			$txtraffic = round($data["netifs"][$i]["tx"]*8);
                        echo "<br>TX: $txtraffic bit / sec<br>";
			// ab hier die txt files für die Weathermap speichern
			$inhalt = "link$row->id\t$rxtraffic\t$txtraffic";
			$handle = fopen ("/var/www/html/rf/scripts/link$row->id.txt", w);
			fwrite ($handle, $inhalt);
			fclose ($handle);
			echo $inhalt;


		}
		$i++;
	}
}
?>

