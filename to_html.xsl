<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:k="https://github.com/kamek-pf/xml-hike">
    
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

            <!-- bandeau et titre associé -->
            <body>
                <img class="k:bandeau">
                    <xsl:attribute name="src">
                        <xsl:value-of select="k:randonnee/k:bandeau/k:image/@src" />
                    </xsl:attribute>
                </img>
                <h2><xsl:value-of select="k:randonnee/k:bandeau/circuit" /></h2>

                <h1><xsl:value-of select="k:randonnee/k:nom" /></h1>
                <h3>SITUATION : <xsl:value-of select="k:randonnee/k:situation" /></h3>
                
                <article>
                    <!--Photo principale -->
                    <img width="400" height="300" class="mright40 fleft">
                        <xsl:attribute name="src">
                            <xsl:value-of select="k:randonnee/k:image/@src" />
                        </xsl:attribute>
                    </img>
                    <!--Introduction et descriptio --> 
                    <section class="inblock width450">
                        <p class="center"><xsl:value-of select="k:randonnee/k:introduction" /></p>
                        <p class="justify"><xsl:value-of select="k:randonnee/k:description" /></p>
                    </section>

                    <!--
                         bandeau indiquant le debut de la description des
                         etapes, puis ajout de toutes les etapes de la randonnee 
                         a l'aide d'une boucle
                    -->
                    <img class="k:bandeau" src="documents/images/50.jpg" />
                    <h2>Description</h2>
                    <section class="block width550 fleft">
                        <xsl:for-each select="k:randonnee/k:etapes/k:etape">
                            <h4><xsl:value-of select="k:id" /> - <xsl:value-of select="k:titre" /></h4>
                            <h5>distance : <xsl:value-of select="k:distance" /> - temps : <xsl:value-of select="k:temps" /></h5>
                            <p><xsl:value-of select="k:description" /></p>
                        </xsl:for-each>
                    </section>

                    <!--
                         Ajout des photos correspondant a chacune des etapes
                         a l'aide d'une boucle
                    -->
                    <section>
                        <xsl:for-each select="k:randonnee/k:etapes/k:etape/k:image">
                            <img width="200" height="200" class="inblock mleft10 mbot30">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="./@src" />
                                </xsl:attribute>
                            </img>
                        </xsl:for-each>
                    </section>

                    <!-- Ajout des deux fiches en fin de document -->
                    <section class="fiche fleft inblock">
                        <h3>FICHE TECHNIQUE</h3>
                        <p>
                            <b>INFORMATION : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:information" /><br />
                            <b>RECOMMANDATIONS : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:recommandations" /><br />
                            <b>DIFFICULTE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:difficulte" /><br />
                            <b>EPOQUE CONSEILLEE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:epoque" /><br />
                            <b>DENIVELE TOTAL : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:denivele" /><br />
                            <b>LONGUEUR TOTALE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:longueur" /><br />
                            <b>ALTITUDE DE DEPART : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:altitude/k:depart" /><br />
                            <b>ALTITUDE D'ARRIVEE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:altitude/k:arrivee" /><br />
                            <b>ALTITUDE MAXI : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:altitude/k:max" /><br />
                            <b>HORRAIRE TOTAL : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:temps" /><br />
                            <b>LIEU DE DEPART : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:lieu/k:depart" /><br />
                            <b>LIEU D'ARRIVEE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:lieu/k:arrivee" /><br />
                            <b>COMMUNE PROCHE DU DEPART : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:commune/k:depart" /><br />
                            <b>COMMUNE PROCHE DE L'ARRIVEE : </b><xsl:value-of select="k:randonnee/k:ftechnique/k:commune/k:arrivee" /><br />
                        </p>
                    </section>
                    <section class="fiche inblock mleft200"> 
                        <h3>FICHE D'INFORMATION</h3>
                        <p>
                            <b>CARTE NECESSAIRE : </b><xsl:value-of select="k:randonnee/k:finformation/k:carte" /><br />
                            <b>CARROYAGE : </b><xsl:value-of select="k:randonnee/k:finformation/k:carroyage" /><br />
                            <b>NOM : </b><xsl:value-of select="k:randonnee/k:finformation/k:nom" /><br />
                            <b>ACCES ROUTIER : </b><xsl:value-of select="k:randonnee/k:finformation/k:acces" /><br />
                            <b>TYPE DE PARCOURS : </b><xsl:value-of select="k:randonnee/k:finformation/k:type/k:parcours" /><br />
                            <b>TYPE DE CHEMIN : </b><xsl:value-of select="k:randonnee/k:finformation/k:type/k:chemin" /><br />
                            <b>TYPE DE TERRAIN : </b><xsl:value-of select="k:randonnee/k:finformation/k:type/k:terrain" /><br />
                            <b>MATERIEL : </b><xsl:value-of select="k:randonnee/k:finformation/k:materiel" /><br />
                        </p>
                    </section>
                
                </article>
            </body>
        </html>

    </xsl:template>
</xsl:stylesheet>
