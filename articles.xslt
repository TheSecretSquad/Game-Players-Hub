<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:    articles.xslt 
Author:  Peter DiSalvo
Date:    April 2012

Purpose:  Styles articles page.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gn="http://www.gameplayershub.com/gameNews"
                xmlns:na="http://www.gameplayershub.com/newsArticle"
                xmlns:gc="http://www.gameplayershub.com/gameCatalog">

  <xsl:import href="sharedArticleStyles.xslt" />

  <xsl:variable name="gameCatalog" select="document(/gn:publicationsExtCatalog/gn:externalGameCatalogURL)" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Game Players Hub</title>
        <link rel="stylesheet" type="text/css" href="GPHStyles.css" />
      </head>
      <body>
        <header>
          <!-- BEGIN headerContent -->
          <div id="headerContent">
            <p id="tagLine">Video game news, reviews and a place to be heard.</p>
            <div id="navWrapper">
              <nav>
                <a href="{$aboutPageName}">About</a>
                <a href="{$articlesPageName}" class="current">Articles</a>
                <a href="{$gamesPageName}" >Games</a>
                <a href="{$indexPageName}">Home</a>
              </nav>
            </div>
          </div>
        </header>
        <div id="headerBottomDivider">
          <xsl:text> </xsl:text>
        </div>
        <div id="headerBottomShadow">
          <xsl:text> </xsl:text>
        </div>
        <!-- BEGIN articles -->
        <section id="mainContent" class="thin">
          <xsl:apply-templates select="gn:publicationsExtCatalog/na:newsArticle|gn:publicationsExtCatalog/gn:review">
            <xsl:sort data-type="number" select="translate(na:date, '-', '')" order="descending" />
          </xsl:apply-templates>
        </section>
        <!-- END articles -->
        <div id="footerTopDivider">
          <xsl:text> </xsl:text>
        </div>
        <footer>
          <div id="footerContent">
            <div id="footerNav">
              <a href="{$indexPageName}">Home</a>
              <a href="{$gamesPageName}">Games</a>
              <a href="{$articlesPageName}">Articles</a>
              <a href="{$aboutPageName}">About</a>
            </div>
          </div>
        </footer>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="na:newsArticle">
    <article id="{@id}">
      <div class="articleBlock">
        <xsl:apply-templates select="na:title" mode="newsArticle" />

        <p class="articleMiniText">
          <xsl:apply-templates select="na:author" />
        </p>

        <p class="articleMiniText">
          <span class="labelText">Date: </span>
          <xsl:apply-templates select="na:date" />
        </p>

        <div class="articleContent">
          <img class="articlePhoto" src="{@photo}" />
          <xsl:choose>
            <xsl:when test="na:content">
              <xsl:value-of disable-output-escaping="yes" select="na:content"/>
            </xsl:when>
            <xsl:when test="na:externalLink">
              <xsl:apply-templates select="na:externalLink" />
            </xsl:when>
            <xsl:when test="na:contentPath">
              <xsl:copy-of select="document(na:contentPath)/html/body/*" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </div>
    </article>
  </xsl:template>

  <xsl:template match="gn:review">
    <article id="{@id}" class="review">
      <div class="gameInfoBlock">
        <div class="titleDetails">
          <xsl:apply-templates select="@forItems" />
        </div>
        <div class="scoreBlock">
          <xsl:apply-templates select="gn:scores" />
        </div>
      </div>
      <hr class="gameInfoArticleDivider"/>
      <div class="articleBlock">
        <xsl:apply-templates select="na:title" mode="reviewArticle" />

        <p class="articleMiniText">
          <xsl:apply-templates select="na:author" />
        </p>

        <p class="articleMiniText">
          <span class="labelText">Date: </span>
          <xsl:apply-templates select="na:date" />
        </p>

        <div class="articleContent">
          <img class="articlePhoto" src="{@photo}" />
          <xsl:choose>
            <xsl:when test="na:content">
              <xsl:value-of disable-output-escaping="yes" select="na:content"/>
            </xsl:when>
            <xsl:when test="na:externalLink">
              <xsl:apply-templates select="na:externalLink" />
            </xsl:when>
            <xsl:when test="na:contentPath">
              <xsl:copy-of select="document(na:contentPath)/html/body/*" />
            </xsl:when>
          </xsl:choose>
        </div>

      </div>
    </article>
  </xsl:template>

</xsl:stylesheet>