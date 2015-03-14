<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Termin">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Termine</title>
			</head>
			<body>
				<br/>
				<br/>
				<span>Termine</span>
				<table>
					<thead>
						<tr>
							<th>Beginn</th>
							<th>Ende</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<xsl:apply-templates select="TerminInfos"/>
						</tr>
					</tbody>
				</table>
				<br/>
				<span>Dauer: </span>
				<xsl:value-of select="./TerminInfos/Dauer/text()"/> (<xsl:value-of select="./TerminInfos/Dauer/@einheit"/>)<br/>
				<span>Verschiebbar: </span>
				<xsl:value-of select="./@verschiebbar"/>
				<br/>
				<span>Serientermin: </span>
				<xsl:value-of select="./@Serientermin"/>
				<br/>
				<br/>
				<span>Teilnehmer</span>
				<xsl:apply-templates select="TeilnehmerListe"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Beginn">
		<td>
			<xsl:value-of select="Datum/@tag"/>-<xsl:value-of select="Datum/@monat"/>-<xsl:value-of select="Datum/@jahr"/> (<xsl:value-of select="Uhrzeit/@stunden"/>:<xsl:value-of select="Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<xsl:template match="Ende">
		<td>
			<xsl:value-of select="Datum/@tag"/>-<xsl:value-of select="Datum/@monat"/>-<xsl:value-of select="Datum/@jahr"/> (<xsl:value-of select="Uhrzeit/@stunden"/>:<xsl:value-of select="Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<xsl:template match="Dauer">
	</xsl:template>
	<xsl:template match="TeilnehmerListe">
		<br/>
		<br/>
		<span>Teilnehmer</span>
		<table>
			<tbody>
				<xsl:apply-templates select="Person"/>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="Person">
		<tr>
			<td>
				Teilnehmer <xsl:number/>
			</td>
			<td>
				<xsl:value-of select="Nachname/text()"/>, <xsl:value-of select="Vorname/text()"/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="Beschreibung"/>
	<xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
</xsl:stylesheet>
