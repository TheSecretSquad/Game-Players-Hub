<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:     about.xslt
Author:   Peter DiSalvo
Date:     April 2012

Purpose:  Generates about page.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="sharedArticleStyles.xslt" />
  <xsl:variable name="aboutPage" select="document(/styler/xmlDoc)" />
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
                <a href="{$aboutPageName}" class="current">About</a>
                <a href="{$articlesPageName}">Articles</a>
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
        <xsl:copy-of select="$aboutPage//*[@id='mainContent']" />
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
