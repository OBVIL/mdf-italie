<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
>
  <!--
  <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="yes"/>
     doctype-system="about:legacy-compat"
  -->
  <xsl:output
     method="html"
     encoding="UTF-8"
     indent="yes"
  />
  <xsl:template match="/tei:TEI">
    <html lang="{@xml:lang}">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="mdf_cat.css"/>
      </head>
      <body>
        <nav id="table">
          <table class="sortable">
            <thead>
              <tr>
                <th><div>N°</div></th>
                <th><div>Auteur</div></th>
                <th><div>Date</div></th>
                <th><div>Titre</div></th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="/*/tei:text/tei:body/*">
                <tr>
                  <td class="no">
                    <xsl:number/>
                  </td>
                  <td class="author">
                    <xsl:choose>
                      <xsl:when test="tei:byline/tei:docAuthor">
                        <xsl:apply-templates select="tei:byline/tei:docAuthor[1]/node()"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:apply-templates select="tei:byline/node()"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td class="date">
                    <xsl:value-of select="substring-before(substring-after(@xml:id, '_'), '_')"/>
                  </td>
                  <td class="title">
                    <a href="#{@xml:id}">
                      <xsl:apply-templates select="tei:head/node()"/>
                    </a>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </nav>
        <main id="main">
          <xsl:apply-templates select="/*/tei:text/tei:body/*"/>
        </main>
      </body>
      
    </html>
      <script src="Sortable.js">//</script>
  </xsl:template>
  <xsl:template match="tei:div">
    <article id="{@xml:id}">
      <xsl:apply-templates/>
    </article>
  </xsl:template>
  <xsl:template match="tei:byline">
    <div class="byline">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:div/tei:head">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>
  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='i']">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='b']">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='sup']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='u']">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>
  <xsl:template match="tei:quote">
    <blockquote>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template>
  <xsl:template match="tei:l">
    <div class="l">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>
  <xsl:template match="tei:docAuthor">
    <span class="author">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:bibl">
    <div class="bibl">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:listBibl">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  <xsl:template match="tei:listBibl/tei:head">
    <h6>
      <xsl:apply-templates/>
    </h6>
  </xsl:template>
  <xsl:template match="tei:listBibl/tei:bibl">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="tei:title">
    <em class="title">
      <xsl:apply-templates/>
    </em>
  </xsl:template>
    <!-- <*>, modèle par défaut d'interception des éléments non pris en charge -->
  <xsl:template match="*">
    <div>
      <xsl:call-template name="tag"/>
      <xsl:apply-templates/>
      <b style="color:red">
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
      </b>
    </div>
  </xsl:template>

  <!-- Utile au déboguage, affichage de l'élément en cours -->
  <xsl:template name="tag">
    <b style="color:red">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:for-each select="@*">
        <xsl:text> </xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>="</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
      </xsl:for-each>
      <xsl:text>&gt;</xsl:text>
    </b>
  </xsl:template>

</xsl:transform>