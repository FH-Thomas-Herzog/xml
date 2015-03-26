<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>
	<!-- Termin Templae rendering -->
	<xsl:template match="Termin">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Termine</title>
			</head>
			<body>
				<!-- Loop over each Person in Teilnehmerliste -->
				<xsl:for-each select="TeilnehmerListe/Person">
					<span>
						<xsl:number/>.) 
						<xsl:value-of select="Nachname"/>, 
						<xsl:value-of select="Vorname"/>
					</span>
					<!-- Call related TerminInfos -->
					<xsl:call-template name="termin_info_template"/>
					<br/>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	<!-- TerminInfos Template rendering  -->
	<xsl:template name="termin_info_template">
		<table border="1">
			<tbody>
				<tr>
					<th>Beginn</th>
					<th>Ende</th>
				</tr>
			</tbody>
			<tr>
				<xsl:call-template name="begin_date_template"/>
				<xsl:call-template name="end_date_template"/>
			</tr>
			<tr>
				<xsl:call-template name="begin_time_template"/>
				<xsl:call-template name="end_time_template"/>
			</tr>
		</table>
	</xsl:template>
	<!-- -Beginn Date Template rendering -->
	<xsl:template name="begin_date_template">
		<td>
			<xsl:value-of select="//TerminInfos/Beginn/Datum/@tag"/>-
					<xsl:value-of select="//TerminInfos/Beginn/Datum/@monat"/>-
					<xsl:value-of select="//TerminInfos/Beginn/Datum/@jahr"/>
		</td>
	</xsl:template>
	<!-- Ende Date Template rendering -->
	<xsl:template name="end_date_template">
		<td>
			<xsl:value-of select="//TerminInfos/Ende/Datum/@tag"/>-
					<xsl:value-of select="//TerminInfos/Ende/Datum/@monat"/>-
					<xsl:value-of select="//TerminInfos/Ende/Datum/@jahr"/>
		</td>
	</xsl:template>
	<!-- Beginn Time Template rendering -->
	<xsl:template name="begin_time_template">
		<td>
			<xsl:value-of select="//TerminInfos/Beginn/Uhrzeit/@stunden"/>:
					<xsl:value-of select="//TerminInfos/Beginn/Uhrzeit/@minuten"/>
		</td>
	</xsl:template>
	<!-- Ende Time Template rendering -->
	<xsl:template name="end_time_template">
		<td>
			<xsl:value-of select="//TerminInfos/Ende/Uhrzeit/@stunden"/>:
					<xsl:value-of select="//TerminInfos/Ende/Uhrzeit/@minuten"/>
		</td>
	</xsl:template>
</xsl:stylesheet>
