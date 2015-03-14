xquery version "1.0";
declare namespace ext="http://www.altova.com/xslt-extensions";
(: 
1.1
for $item in doc("Appointments.xml")//Beginn
order by $item/@datum ascending
return $item 
:)

(:
 1.2 
<AlleSerientermine>
{
for $item in doc("Appointments.xml")/TerminListe/Termin[@serienTermin = 'ja']/Beginn
order by $item/@datum ascending
return $item
}
</AlleSerientermine>
:)

(:
1.3 
for $item in doc("Appointments.xml")/TerminListe/Termin[@serienTermin = 'ja']/Beginn
order by $item/@datum ascending
return <SerienTermin>{$item}</SerienTermin>
:)

(: 
1.4 
for $item in doc("Appointments.xml")/TerminListe/Termin[@serienTermin = 'ja']
order by $item/Beginn/@datum ascending
return <SerienTermin>{$item/Beschreibung}</SerienTermin>
:)

(: 1.5 
for $item in doc("Appointments.xml")/TerminListe/Termin[@serienTermin = 'ja']
order by $item/Beginn/@datum ascending
return if (exists($item/Beschreibung)) then <Termin>{$item/Beschreibung}</Termin>
else ()
:)

(: 1.6
let $items := distinct-values(doc("RoomList.xml")//Raum/Details[@sitzPlätze > 150])
return exists($items)
:)

(: 1.7 
for $item in doc("Appointments.xml")/TerminListe/Termin[@serienTermin = 'ja']
order by $item/@datum ascending
return <SerienTermin ersteller="{$item/@terminErsteller}" erstellDatum="{$item/@erstellDatum}" verschiebbar="{$item/@verschiebbar}">{$item/Beschreibung}</SerienTermin>
:)

(: 1.8 
for $item in doc("Appointments.xml")/TerminListe/Termin
order by $item/@datum ascending
:)

(: 1.9 
for $item in doc("PersonList.xml")/PersonenListe/Person
order by $item/@id ascending
return <Person name="{$item/@vorname}" anzahlTermine="{sum($item/TerminEintrag/@terminNr)}"></Person>
:)

(: 1.10 
for $item in distinct-values(doc("PersonList.xml")//TerminEintrag/@terminNr)
return element{concat('T', $item)}
	{
		for $person in doc("PersonList.xml")//Person
		where $item = $person/TerminEintrag/@terminNr 
		return $person
	}
:)

(: 1.11 
for $item in doc("Appointments.xml")//Termin
return <Termin number="{$item/Nummer}" terminErsteller="{$item/@terminErsteller}" erstellDatum="{$item/@erstellDatum}" verschiebbar="{$item/@verschiebbar}" serienTermin="{$item/@serienTermin}">{$item/(* except Nummer)}</Termin>
:)

(: 1.12  
for $appointment in doc("Appointments.xml")/TerminListe/Termin, $person in doc("PersonList.xml")//Person
where $appointment/@terminErsteller = $person/@id
return <Person id="{$person/@id}" vorname="{$person/@vorname}" nachname="{$person/@nachname}" terminBeschreibung="{$appointment/Beschreibung}" ></Person>
:)

(: 1.13 
for $appointment in doc("Appointments.xml")/TerminListe/Termin, $person in doc("PersonList.xml")//Person
return <Person id="{$person/@id}" vorname="{$person/@vorname}" nachname="{$person/@nachname}">{$appointment/(Beginn, Ende, Dauer, Beschreibung, Benachrichtigung)}</Person>
:)

(: 1.14 
for $person in doc("PersonList.xml")//Person
return <Person id="{$person/@id}" vorname="{$person/@vorname}" nachname="{$person/@nachname}">
<TerminEinträge>
{
for $item in doc("Appointments.xml")/TerminListe/Termin[Nummer = $person/TerminEintrag/@terminNr]
return <Termin nummer="{$item/Nummer}">{$item/(Beginn, Ende, Dauer, Beschreibung, Benachrichtigung)}</Termin>
}
</TerminEinträge></Person>
:)

(: 1.15 ?????????????? 
for $appintment in doc("Appointments.xml")//Termin, 
$person in doc("PersonList.xml")//Person,
$room in doc("RoomList.xml")//Raum
where ($appintment/Nummer = $person/TerminEintrag/@terminNr)
and ( $person/TerminEintrag/@terminNr = $room/Belegung/@terminNr)
return <Termin beschreibung="{$appintment/Beschreibung}" teilnehmer="{concat($person/@nachname, concat(' ', $person/@vorname))}" raum="{$room/@id}"></Termin>
:)

(: 1.16 
for $room in doc("RoomList.xml")//Raum
return <Raum nummer="{$room/@id}">
{
for $appointment in doc("Appointments.xml")//Termin[Nummer = $room/Belegung/@terminNr]/Beschreibung
return $appointment
}
</Raum>
:)

(: 1.17 :)
for $appointment in doc("Appointments.xml")//Termin
return if ($appointment/@verschiebbar = 'ja' and $appointment/@serienTermin = 'ja') then (
		<Verschiebbar_Serie>{concat($appointment/Nummer, (
		if (exists($appointment/Beschreibung)) then (
			concat(' ', $appointment/Beschreibung)
		) 
		else ()))}</Verschiebbar_Serie>
)
else if  ($appointment/@verschiebbar = 'ja' and $appointment/@serienTermin = 'nein') then (
	<Verschiebbar_KeineSerie>{concat($appointment/Nummer, (
		if (exists($appointment/Beschreibung)) then (
			concat(' ', $appointment/Beschreibung)
		) 
		else ()))}</Verschiebbar_KeineSerie>
)
else if  ($appointment/@verschiebbar = 'nein' and $appointment/@serienTermin = 'ja') then (
	<NichtVerschiebbar_Serie>{concat($appointment/Nummer, (
		if (exists($appointment/Beschreibung)) then (
			concat(' ', $appointment/Beschreibung)
		) 
		else ()))}</NichtVerschiebbar_Serie>
)
else if  ($appointment/@verschiebbar = 'nein' and $appointment/@serienTermin = 'nein') then (
	<NichtVerschiebbar_KeineSerie>{concat($appointment/Nummer, (
		if (exists($appointment/Beschreibung)) then (
			concat(' ', $appointment/Beschreibung)
		) 
		else ()))}</NichtVerschiebbar_KeineSerie>
)
else ()