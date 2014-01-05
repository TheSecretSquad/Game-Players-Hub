<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:    games.xslt
Author:  Peter DiSalvo
Date:    April 2012

Purpose:  Styles game catalog.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gn="http://www.gameplayershub.com/gameNews"
                xmlns:na="http://www.gameplayershub.com/newsArticle"
                xmlns:gc="http://www.gameplayershub.com/gameCatalog"
                xmlns:sal="http://www.gameplayershub.com/sale">
  
  <xsl:include href="sharedArticleStyles.xslt" />
  
  <xsl:variable name="reviews" select="document($articlesParsePage)" />

  <xsl:key name="GameReleaseByPlatform" match="gc:gameCatalog/gc:game/gc:release" use="@platform"/>
  <xsl:key name="SalesByRelease" match="gc:gameCatalog/sal:salesCatalog/sal:sale" use="@forItem" />

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
                <a href="{$articlesPageName}">Articles</a>
                <a href="{$gamesPageName}" class="current">Games</a>
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
        <section id="mainContent" class="games">
          <!-- Group games by platform -->
          <xsl:for-each select="gc:gameCatalog/gc:platformsCatalog/gc:platform[@id = key('GameReleaseByPlatform', @id)/@platform]">
            <xsl:sort data-type="text" order="ascending" case-order="upper-first" select="gc:system"/>
            <div class="platformSection">
              <xsl:apply-templates select="." />
              <table class="gameAttrs releases">
                <col style="width: 35%;"/>
                <col style="width: 15%" />
                <col style="width: 10%;" />
                <tr>
                  <th>Title</th>
                  <!--<th>Avg. Score</th> Game averages do not work because contains function does not match whole words (see below)-->
                  <th>Release Date</th>
                  <th>MSRP</th>
                  <th>Sales</th>
                </tr>
                <xsl:apply-templates select="key('GameReleaseByPlatform', @id)">
                  <xsl:sort data-type="text" order="ascending" case-order="upper-first" select="../gc:title" />
                </xsl:apply-templates>
              </table>
            </div>
          </xsl:for-each>
        </section>
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

  <xsl:template match="gc:platform">
    <h1 id="{@id}">
      <xsl:value-of select="gc:system" />
    </h1>
  </xsl:template>

  <xsl:template match="gc:release">
    <tr>
      <td>
        <xsl:apply-templates select="../gc:title"/>
        <xsl:choose>
          <xsl:when test="../@homepage">
            <a href="{../@homepage}" target="_blank">
              <img src="{@image}" alt="{../gc:title} game cover" />
            </a>
          </xsl:when>
          <xsl:otherwise>
            <img src="{@image}" alt="{../gc:title} game cover" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <!-- Game averages do not work because contains function does not match whole words
      <td>
        <xsl:variable name="releaseID" select="@id" />
        <xsl:for-each select="$reviews">
          --><!-- Calculate total score for game using all score values from all reviews --><!--
          <xsl:variable name="percentDecimalValue" select="sum(//*[contains(@forItems, $releaseID)]//gn:scores//gn:score//gn:value) div count(//*[contains(@forItems, $releaseID)]//gn:scores//gn:score//gn:value)" />
          <xsl:choose>
            <xsl:when test="string($percentDecimalValue) != 'NaN'">
              <xsl:call-template name="completePercentHTML">
                <xsl:with-param name="decimalValue" select="$percentDecimalValue" />
                <xsl:with-param name="wrapWithHTML" select="'h1'" />
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              No Reviews
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </td>
      -->
      <td>
        <xsl:call-template name="convertDate">
          <xsl:with-param name="date" select="gc:releaseDate" />
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="priceFormat">
          <xsl:with-param name="price" select="gc:msrp"  />
        </xsl:call-template>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="key('SalesByRelease', @id)">
            <table class="gameAttrs saleItems">
              <tr>
                <th>Vendor</th>
                <th>Price</th>
                <th>Save</th>
                <th>Starts</th>
                <th>Ends</th>
              </tr>
              <xsl:apply-templates select="key('SalesByRelease', @id)">
                <xsl:with-param name="msrp" select="gc:msrp" />
                <xsl:sort data-type="number" order="ascending" select="sal:price" />
              </xsl:apply-templates>
            </table>
          </xsl:when>
          <xsl:otherwise>
            None
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="gc:title">
    <h3>
      <xsl:value-of select="." />
    </h3>
  </xsl:template>

  <xsl:template match="sal:sale">
    <xsl:param name="msrp" />
    <xsl:variable name="salePrice" select="sal:price" />
    <tr>
      <td>
        <a href="{@link}">
          <xsl:value-of select="sal:vendorName" />
        </a>
      </td>
      <td>
        <xsl:call-template name="priceFormat">
          <xsl:with-param name="price" select="$salePrice" />
        </xsl:call-template>
      </td>
      <td>
        <xsl:variable name="discount" select="$msrp - sal:price" />
        <xsl:call-template name="priceFormat">
          <xsl:with-param name="price" select="$discount" />
        </xsl:call-template>
        (<xsl:value-of select="format-number($discount div $msrp, '##0%')"/>)
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="sal:startDate">
            <xsl:apply-templates select="sal:startDate" />
          </xsl:when>
          <xsl:otherwise>
            N/A
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="sal:endDate">
            <xsl:apply-templates select="sal:endDate" />
          </xsl:when>
          <xsl:otherwise>
            N/A
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="sal:startDate|sal:endDate">
    <xsl:call-template name="convertDate2">
      <xsl:with-param name="date" select="." />
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>