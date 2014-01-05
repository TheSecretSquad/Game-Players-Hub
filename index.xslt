<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:     index.xslt
Author:   Peter DiSalvo
Date:     April 2012

Purpose:  Styles main page and article previews.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gn="http://www.gameplayershub.com/gameNews"
                xmlns:na="http://www.gameplayershub.com/newsArticle"
                xmlns:gc="http://www.gameplayershub.com/gameCatalog">
  <xsl:import href="sharedArticleStyles.xslt" />

  <xsl:variable name="publications" select="document(/styler/xmlDoc)" />
  <xsl:variable name="gameCatalog" select="document($publications/gn:publicationsExtCatalog/gn:externalGameCatalogURL)" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Game Players Hub</title>
        <link rel="stylesheet" type="text/css" href="GPHStyles.css" />
        <script type="text/javascript" src="toggle.js">
          <xsl:text> </xsl:text>
        </script>
      </head>
      <body>
        <header>
          <!-- BEGIN headerContent -->
          <div id="headerContent">
            <p id="tagLine">Video game news, reviews and a place to be heard.</p>
            <div id="navWrapper">
              <nav>
                <a href="{$aboutPageName}">About</a>
                <a href="{$articlesPageName}">Articles</a>
                <a href="{$gamesPageName}">Games</a>
                <a class="current" href="{$indexPageName}">Home</a>
              </nav>
            </div>
            <!-- BEGIN featured -->
            <xsl:apply-templates select="$publications/gn:publicationsExtCatalog/na:newsArticle[@featured = 'true']|$publications/gn:publicationsExtCatalog/gn:review[@featured = 'true']" />
            <!-- END featured -->
          </div>
          <!-- END headerContent -->
        </header>
        <div id="headerBottomDivider">
          <xsl:text> </xsl:text>
        </div>
        <div id="headerBottomShadow">
          <xsl:text> </xsl:text>
        </div>
        <!-- BEGIN articles -->
        <section id="mainContent" class="thin">
          <xsl:apply-templates select="$publications/gn:publicationsExtCatalog/na:newsArticle[not(@featured) or @featured = 'false']|$publications/gn:publicationsExtCatalog/gn:review[not(@featured) or @featured = 'false']">
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
</xsl:stylesheet>