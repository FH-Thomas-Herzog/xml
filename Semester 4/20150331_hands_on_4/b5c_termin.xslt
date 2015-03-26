<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="b5_formatierung.xslt"/>
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
							<!-- Call Beginn and Ende Templates -->
							<xsl:call-template name="begin_template"/>
							<xsl:call-template name="end_template"/>
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
				<table border="1">
					<tbody>
						<!-- Iterate over each Person and call corresponding template -->
						<xsl:for-each select="TeilnehmerListe/Person">
							<xsl:call-template name="person_template"/>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
	<!-- Beginn Template rendering -->
	<xsl:template name="begin_template">
		<td>
			<xsl:value-of select="TerminInfos/Beginn/Datum/@tag"/>-<xsl:value-of select="TerminInfos/Beginn/Datum/@monat"/>-<xsl:value-of select="TerminInfos/Beginn/Datum/@jahr"/> (<xsl:value-of select="TerminInfos/Beginn/Uhrzeit/@stunden"/>:<xsl:value-of select="TerminInfos/Beginn/Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<!-- Ende Template rendering -->
	<xsl:template name="end_template">
		<td>
			<xsl:value-of select="TerminInfos/Ende/Datum/@tag"/>-<xsl:value-of select="TerminInfos/Ende/Datum/@monat"/>-<xsl:value-of select="TerminInfos/Ende/Datum/@jahr"/> (<xsl:value-of select="TerminInfos/Ende/Uhrzeit/@stunden"/>:<xsl:value-of select="TerminInfos/Ende/Uhrzeit/@minuten"/>)
		</td>
	</xsl:template>
	<!-- Person Template rendering -->
	<xsl:template name="person_template">
		<tr>
			<td>
			</td>
			<td>
				<xsl:number/>
				<xsl:value-of select="Nachname/text()"/>, <xsl:value-of select="Vorname/text()"/>
				<xsl:if test="@id = //Termin/TerminInfos/@Terminersteller"> (is creator)</xsl:if>
				<br/>
				<xsl:call-template name="delimiter_template"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
