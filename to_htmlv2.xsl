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
                <!-- 
                     On doit appeller apply-templates manuellement sur les
                     elements de <randonnee /> afin de les placer dans les bonnes
                     sections (pour les CSS)
                -->
                <xsl:apply-templates select="randonnee/bandeau/image" />
                <xsl:apply-templates select="randonnee/bandeau/circuit" />
                <xsl:apply-templates select="randonnee/nom | randonnee/situation" />
                <article>
                    <xsl:apply-templates select="randonnee/image" />
                    <section class="inblock width450">
                        <xsl:apply-templates select="randonnee/introduction | randonnee/description" />
                    </section>
                    <img class="bandeau" src="documents/images/50.jpg" />
                    <h2>Description</h2>
                    <section class="block width550 fleft">
                        <xsl:apply-templates select="randonnee/etapes" />
                    </section>
                    <section>
                        <xsl:apply-templates select="randonnee/etapes/etape/image" />
                    </section>
                    <section class="fiche fleft inblock">
                        <h3>FICHE TECHNIQUE</h3>
                        <xsl:apply-templates select="randonnee/ftechnique" />
                    </section>
                    <section class="fiche inblock mleft200">
                        <h3>FICHE D'INFORMATION</h3>
                        <xsl:apply-templates select="randonnee/finformation" />
                    </section>
                </article>
            </body>
        </html>

    </xsl:template>

    <!-- Variables CSS a passer en parametre aux templates -->
    <xsl:variable name="c_bandeau">bandeau </xsl:variable>
    <xsl:variable name="c_step">block width550 fleft </xsl:variable>
    <xsl:variable name="c_justify">justify </xsl:variable>
    <xsl:variable name="c_center">center </xsl:variable>
    <xsl:variable name ="c_pics">inblock mleft10 mbot30 </xsl:variable>
    <xsl:variable name ="c_photo">mright40 fleft </xsl:variable>
    <xsl:variable name="v_200">200 </xsl:variable>
    <xsl:variable name="v_300">300 </xsl:variable>
    <xsl:variable name="v_400">400 </xsl:variable>

    <!-- 
        On appel les templates definis en fin de document pour generer la page HTML.
        On passe les classes CSS en parametre (avec xsl:with-param) aux balises
        HTML concernees.
    -->

    <xsl:template match="nom">
        <xsl:call-template name="h1" />
    </xsl:template>
    
    <xsl:template match="situation">
        <xsl:call-template name="h3" />
    </xsl:template>

    <xsl:template match="bandeau/image">
        <xsl:call-template name="image">
            <xsl:with-param name="classes" select="$c_bandeau" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="bandeau/circuit">
        <xsl:call-template name="h2" />
    </xsl:template>

    <xsl:template match="randonnee/image">
        <xsl:call-template name="image">
            <xsl:with-param name="classes" select="$c_photo" />
            <xsl:with-param name="height" select="$v_300" />
            <xsl:with-param name="width" select="$v_400" />
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
        <xsl:call-template name="sousTitreEtape" />
        <xsl:call-template name="description" />
    </xsl:template>

    <xsl:template match="etape/image">
        <xsl:call-template name="image">
            <xsl:with-param name="classes" select="$c_pics" />
            <xsl:with-param name="height" select="$v_200" />
            <xsl:with-param name="width" select="$v_200" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="ftechnique/* | finformation/*">
        <xsl:call-template name="fiches">
            <xsl:with-param name="classes" select="$c_justify" />
        </xsl:call-template>: 
        <xsl:call-template name="texte" /><br />
    </xsl:template>

    <!-- 
         Definition de templates generiques 
    -->
    <!-- Afficher une image -->
    <xsl:template name="image">
        <xsl:param name="classes" /> 
        <xsl:param name="height" /> 
        <xsl:param name="width" /> 
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="./@src" />
            </xsl:attribute>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
        </img>
    </xsl:template>

    <!-- Afficher du texte non balisé -->
    <xsl:template name="texte">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- Afficher un paragraphe -->
    <xsl:template name="p">
        <xsl:param name="classes" /> 
        <p>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <!-- Afficher un titre de niveau 1 -->
    <xsl:template name="h1">
        <xsl:param name="classes" /> 
        <h1>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    
    <!-- Afficher un titre de niveau 1 -->
    <xsl:template name="h2">
        <xsl:param name="classes" /> 
        <h2>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>

    <!-- Afficher un titre de niveau 3 -->
    <xsl:template name="h3">
        <xsl:param name="classes" /> 
        <h3>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="."/>
        </h3>
    </xsl:template>

    <!-- Afficher les noms des sous parties des fiches techniques ou d'information -->
    <xsl:template name="fiches">
        <xsl:param name="classes" /> 
        <b><xsl:value-of select="local-name()" /></b>
    </xsl:template>

    <!-- Afficher la description d'une etape-->
    <xsl:template name="description">
        <xsl:param name="classes" /> 
        <p>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            <xsl:value-of select="description"/>
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

    <!-- Afficher le sous-titre d'une etape -->
    <xsl:template name="sousTitreEtape">
        <xsl:param name="classes" /> 
        <h5>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
            distance : <xsl:value-of select="distance" /> - temps : <xsl:value-of select="temps" />
        </h5>
    </xsl:template>


</xsl:stylesheet>
