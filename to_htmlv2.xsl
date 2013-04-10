<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>

        <html lang="fr">
            <head>
                <meta charset="utf-8" />
                <meta name="author" content="Bertrand 'Kamek' BOUSQUET" />
                <link rel="stylesheet" type="text/css" href="style.css" />
                <title>XML to HTML | Randonnée</title>
                <meta name="description" content="Fiche de randonnée" />
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>

    </xsl:template>


    <!-- Variables CSS a passer en parametre aux templates -->
    <xsl:variable name="c_bandeau">bandeau </xsl:variable>
    <xsl:variable name="c_step">block width550 fleft </xsl:variable>
    <xsl:variable name="c_justify">justify </xsl:variable>
    <xsl:variable name="c_center">center </xsl:variable>


    <!-- 
        On appel les templates definis en fin de document pour generer la page HTML.
        On passe les classes CSS en parametre (avec xsl:with-param) aux balises
        HTML concernees.
        Pour les balises auxquelles on doit affecter plusieurs classes CSS, on utilise
        la fonction concat() lors du passage du parametre.
    -->
    <xsl:template match="bandeau">
        <xsl:call-template name="image">
            <xsl:with-param name="classes" select="concat($c_bandeau, $c_step)" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="introduction">
        <xsl:call-template name="p">
            <xsl:with-param name="classes" select="$c_center" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="randonnee/description">
        <xsl:call-template name="p">
            <xsl:with-param name="classes" select="$c_justify" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="etape">
        <xsl:call-template name="titreEtape" />
        <xsl:call-template name="p" />
    </xsl:template>




    <!-- 
         Definition des templates 
    -->
    <!-- Afficher une image -->
    <xsl:template name="image">
        <xsl:param name="classes" /> 
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="image/@src" />
            </xsl:attribute>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
        </img>
    </xsl:template>

    <!-- Afficher un paragraphe -->
    <xsl:template name="p">
         <xsl:param name="classes" /> 
        <p>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <!-- Afficher le titre d'une etape -->
    <xsl:template name="titreEtape">
         <xsl:param name="classes" /> 
        <h4>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="id" /> -  <xsl:value-of select="titre" />
        </h4>
    </xsl:template>

</xsl:stylesheet>
