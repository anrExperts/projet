<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    exclude-result-prefixes="xs tei eg"
    version="1.0">
    
    <xsl:template match="/">
        <html lang="fr">
            <head>
                <title>ANR Experts : XML et EAC-CPF</title>
                <meta charset="utf-8" />
                <style>
                    body {font-family: "hack"; font-size : 20px; max-width:40%; margin:auto; color:rgb(48,58,70); line-height: 1.65;}
                    p {text-align: justify;}
                    em {color:rgb(171,67,64)}
                    q {quotes: "« " " »" "'" "'";}
                    h1 {text-align:center; margin-bottom:250px;}
                    h2 {text-align:center; margin-top:200px; margin-bottom:50px;}
                    h3 {text-align:left; margin-top:150px; margin-bottom:50px;}
                    h4 {text-align:left; margin-top:100px; margin-bottom:50px;}
                    img {width:50px;}
                    pre {padding:50px; margin:50px; background-color:rgb(63,75,88); border-radius:5px; white-space: pre-wrap;}
                    code {color:white;}
                    .alignCenter {text-align:center;}
                    .foreign {font-style:italic;}
                    
                </style>
                <!--<link href="prism.css" rel="stylesheet" />-->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.15.0/themes/prism.css" rel="stylesheet" />
            </head>
            <body>
                <xsl:apply-templates select=".//tei:body" />
                <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.15.0/prism.js">/*XSL*/</script>
                <!--<script src="prism.js">/*transformation XSL*/</script>-->
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p>
            <xsl:if test="@rend"><xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul><xsl:apply-templates /></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates /></li>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:variable name="level" select="count(ancestor::*/tei:head)"/>
        <xsl:element name="h{$level}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:emph">
        <em><xsl:apply-templates /></em>
    </xsl:template>
    
    <xsl:template match="tei:foreign">
        <span class="foreign"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:q">
        <q><xsl:apply-templates /></q>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br />
    </xsl:template>
    
    <xsl:template match="tei:title">
        <i><xsl:apply-templates /></i>
    </xsl:template>
    
    <xsl:template match="tei:gi">
        <b><xsl:text>&lt;</xsl:text><xsl:apply-templates /><xsl:text> /&gt;</xsl:text></b>
    </xsl:template>
    
    <xsl:template match="tei:att">
        <b><xsl:text>@</xsl:text><xsl:apply-templates /></b>
    </xsl:template>
    
    <xsl:template match="tei:graphic">
        <img src="{@url}" />
    </xsl:template>
    
    <xsl:template match="eg:egXML">
        <pre class="language-markup">
            <code>
                <xsl:apply-templates />
                <!--<xsl:copy-of select="node() | @*"/>-->
            </code>
        </pre>
    </xsl:template>
    
    <xsl:template match="eg:egXML//child::*">
        <xsl:text>&lt;</xsl:text><xsl:value-of select="local-name(.)"/><xsl:if test="@*"><xsl:for-each select="@*"><xsl:text> </xsl:text><xsl:value-of select="local-name(.)"/><xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:for-each></xsl:if><xsl:text>&gt;</xsl:text><xsl:apply-templates/><xsl:text>&lt;/</xsl:text><xsl:value-of select="local-name(.)"/><xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="eg:egXML//comment()">
        <xsl:text>&lt;!--</xsl:text><xsl:value-of select="."/><xsl:text>--&gt;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>