<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>
	<!-- Termin Template rendering -->
	<!-- 1. Level (Parent: root node) -->
	<!-- 1. Stage Entry point of traverse -->
	<xsl:template match="Termin">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Termine</title>
			</head>
			<body>
				<br/>
				<table border="1">
					<thead>
						<tr>
							<th>Beginn</th>
							<th>Ende</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- Go to 2. Level -->
							<xsl:apply-templates select="TerminInfos"/>
						</tr>
					</tbody>
				</table>
				<br/>
				<span>Dauer: </span>
				<xsl:value-of select="./TerminInfos/Dauer/text()"/> (<xsl:value-of select="./TerminInfos/Dauer/@einheit"/>)<br/>
				<span>Verschiebbar: </span>
				<xsl:value-of select="TerminInfos/@verschiebbar"/>
				<br/>
				<span>Serientermin: </span>
				<xsl:value-of select="TerminInfos/@Serientermin"/>
				<br/>
				<br/>
				<xsl:apply-templates select="TeilnehmerListe"/>
			</body>
		</html>
	</xsl:template>
	<!-- Beginn Template rendering -->
	<!-- 3. Level (Parent: Termininfos) -->
	<xsl:template match="Beginn">
		<td>
			<xsl:value-of select="Datum/@tag"/>-<xsl:value-of select="Datum/@monat"/>-<xsl:value-of select="Datum/@jahr"/> (<xsl:value-of select="Uhrzeit/@stunden"/>:<xsl:value-of select="Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<!-- Ende Template rendering -->
	<!-- 3. Level (Parent: Termininfos) -->
	<xsl:template match="Ende">
		<td>
			<xsl:value-of select="Datum/@tag"/>-<xsl:value-of select="Datum/@monat"/>-<xsl:value-of select="Datum/@jahr"/> (<xsl:value-of select="Uhrzeit/@stunden"/>:<xsl:value-of select="Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<!-- Nothing to do on Dauer -->
	<!-- 3. Level (Parent: Termininfos) -->
	<xsl:template match="Dauer"/>
	<!-- Nothing to do on Beschreibung -->
	<!-- 3. Level (Parent: TeilnehmerListe) -->
	<xsl:template match="Beschreibung"/>
	<!-- Teilnehmerliste Template rendering -->
	<xsl:template match="TeilnehmerListe">
		<table border="1">
			<tbody>
				<!-- Go to Person node on same level -->
				<xsl:apply-templates select="Person"/>
			</tbody>
		</table>
	</xsl:template>
	<!-- Person Template rendering -->
	<!-- 3. Level (Parent: TeilnehmerListe) -->
	<xsl:template match="Person">
		<tr>
			<td>
				<xsl:number/>
			</td>
			<td>
				<xsl:value-of select="Nachname/text()"/>, <xsl:value-of select="Vorname/text()"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
