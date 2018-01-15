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
			echo $data["netifs"][$i]["rx_bytes"];
			echo "<br />TX Bytes: ";
			echo $data["netifs"][$i]["tx_bytes"];
			//erst prüfen ob ein Datensatz vorhanden ist der <5min alt ist
			$ergebnis1 = mysqli_query($db, "SELECT id_allg_info, time FROM bytes_data WHERE id_allg_info = '$row->id' ORDER BY time");
			while($row1 = mysqli_fetch_object($ergebnis1))
			{
				if ($zeit < $row1->time+100)
				{
					echo "<br />Datensatz in den letzten 5min bereits gespeichert, mache nichts...";
					$block = 1;
				}	
			}
			if ($block != 1)
			{
				echo "<br />safe data";
				$rx_bytes = $data["netifs"][$i]["rx_bytes"];
				$tx_bytes = $data["netifs"][$i]["tx_bytes"];
				$eintrag = "INSERT INTO bytes_data (id_allg_info, rx_bytes, time, tx_bytes) VALUES ('$row->id', '$rx_bytes', '$zeit', '$tx_bytes')";
				$eintragen = mysqli_query($db, $eintrag);
				//Ab hier berechnen wir die Trafficdaten für traffic_data und zwar in /sec über den Schnitt der letzten 2 Datensätze
				$durchgang=0;
		                $ergebnis2 = mysqli_query($db, "SELECT id_allg_info, time, rx_bytes, tx_bytes FROM bytes_data WHERE id_allg_info = '$row->id' ORDER BY time DESC LIMIT 2");
        	                while($row2 = mysqli_fetch_object($ergebnis2))
	                        {
					if ($durchgang == 0)
					{
						$zeitfirst = $row2->time;
						$rx_bytesfirst = $row2->rx_bytes;
						$tx_bytesfirst = $row2->tx_bytes;		
						$durchgang = 1;
					}
					else
					{
						$time = $zeitfirst - $row2->time;
						$rx_bytes2 = $row2->rx_bytes;
						$tx_bytes2 = $row2->tx_bytes;
						$rx_bytes = $rx_bytesfirst - $row2->rx_bytes;
						$tx_bytes = $tx_bytesfirst - $row2->tx_bytes;
						$durchgang = 0;
					}
				}
				echo "<br>$time";
				echo "<br>rx1: $rx_bytesfirst rx2: $rx_bytes2";
				echo "<br>tx1: $tx_bytesfirst tx2: $tx_bytes2";
				echo "<br>rxges: $rx_bytes";
				echo "<br>txges: $tx_bytes<br>";
				//berechne RX:
				$rxtraffic = round($rx_bytes/$time)*8;
				echo "<br>RX: $rxtraffic bit / sec<br>";
				//berechne TX:
				$txtraffic = round($tx_bytes/$time)*8;
                                echo "<br>TX: $txtraffic bit / sec<br>";
                                $ergebnis2 = mysqli_query($db, "SELECT id_allg_info FROM traffic_data WHERE id_allg_info = '$row->id'");
                                while($row2 = mysqli_fetch_object($ergebnis2))
                                {
					$aendern = "UPDATE traffic_data Set rx_traffic  = '$rxtraffic', tx_traffic = '$txtraffic' WHERE id_allg_info = '$row->id'";
					$update = mysqli_query($db, $aendern);
					$vorhanden = 1;
				}
				if ($vorhanden != 1)
				{
					echo "<br>ID neu anlegen<br>";
					$eintrag = "INSERT INTO traffic_data (id_allg_info, rx_traffic, tx_traffic) VALUES ('$row->id', '$rxtraffic', '$txtraffic')";
					$eintragen = mysqli_query($db, $eintrag);
				}
				else
				{
					$vorhanden = 0;
					echo "<br>Bereits vorhanden, Daten wurden bereits aktualisiert...<br>";
				}
				// ab hier die txt files für die Weathermap speichern
				$inhalt = "link$row->id\t$rxtraffic\t$txtraffic";
				$handle = fopen ("/var/www/html/rf/scripts/link$row->id.txt", w);
				fwrite ($handle, $inhalt);
				fclose ($handle);
				echo $inhalt;
			}
			else
			{
				$block = 0;
			}

		}
		$i++;
	}
}
?>
