<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:     sharedArticleStyles.xslt
Author:   Peter DiSalvo
Date:     April 2012

Purpose:  Styles for games and articles shared among multiple pages.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gn="http://www.gameplayershub.com/gameNews"
                xmlns:na="http://www.gameplayershub.com/newsArticle"
                xmlns:gc="http://www.gameplayershub.com/gameCatalog">

  <xsl:include href="outputInstructions.xslt" />
  <xsl:include href="SharedFunctions.xslt" />

  <!-- Game element key index by Release id attribute -->
  <xsl:key name="GameByRelease" match="gc:game" use="gc:release/@id" />

  <!-- Game Release element key index by id attribute -->
  <xsl:key name="Releases" match="gc:game/gc:release" use="@id" />

  <!-- Publisher element key index by id attribute -->
  <xsl:key name="GamePublishers" match="gc:publishersCatalog/gc:publisher" use="@id" />

  <!-- Developer element key index by id attribute -->
  <xsl:key name="GameDevelopers" match="gc:developersCatalog/gc:developer" use="@id" />

  <!-- Platform element key index by id attribute -->
  <xsl:key name="Platforms" match="gc:platformsCatalog/gc:platform" use="@id" />

  <!-- game catalog set to this document as default.
        must be overridden when this file is imported -->
  <xsl:variable name="gameCatalog" select="document('')" />

  <!-- Style news article -->
  <xsl:template match="na:newsArticle">
    <article>
      <div class="articleBlock">
        <xsl:apply-templates select="na:title" mode="newsArticle" />

        <p class="articleMiniText">
          <xsl:apply-templates select="na:author" />
        </p>

        <p class="articleMiniText">
          <span class="labelText">Date: </span>
          <xsl:apply-templates select="na:date" />
        </p>

        <div class="articleSummary">
          <img class="articlePhoto" src="{@photo}" />
          <xsl:apply-templates select="na:synopsis" />
          <xsl:call-template name="createLinkToArticle">
            <xsl:with-param name="articleID" select="@id" />
          </xsl:call-template>
        </div>
      </div>
    </article>
  </xsl:template>

  <!-- Style featured news article-->
  <xsl:template match="na:newsArticle[@featured = 'true']">
    <article id="featured">
      <img src="{@photo}" />
      <xsl:apply-templates select="na:title" mode="newsArticle" />
      <p class="articleMiniText">
        <xsl:apply-templates select="na:author" />
      </p>
      <p class="articleMiniText">
        <span class="labelText">Date: </span>
        <xsl:apply-templates select="na:date" />
      </p>
      <p>
        <br />
        <xsl:apply-templates select="na:synopsis" />
      </p>
      <xsl:call-template name="createLinkToArticle">
        <xsl:with-param name="articleID" select="@id" />
      </xsl:call-template>
    </article>
  </xsl:template>

  <!-- Style review -->
  <xsl:template match="gn:review">
    <article class="review">
      <div class="gameInfoBlock">
        <div class="titleDetails">
          <xsl:apply-templates select="@forItems" />
        </div>
        <div class="scoreBlock">
          <xsl:apply-templates select="gn:scores" mode="expandButton" />
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

        <div class="articleSummary">
          <img class="articlePhoto" src="{@photo}" />
          <xsl:apply-templates select="na:synopsis" />
          <xsl:call-template name="createLinkToArticle">
            <xsl:with-param name="articleID" select="@id" />
          </xsl:call-template>
        </div>
      </div>
    </article>
  </xsl:template>

  <!-- Style featured review-->
  <xsl:template match="gn:review[@featured = 'true']">
    <article id="featured">
      <img src="{@photo}" />
      <xsl:apply-templates select="@forItems" />
      <xsl:apply-templates select="gn:scores" mode="featuredReview" />
      <hr class="gameInfoArticleDivider" />
      <xsl:apply-templates select="na:title" mode="reviewArticle" />
      <p class="articleMiniText">
        <xsl:apply-templates select="na:author" />
      </p>
      <p class="articleMiniText">
        <span class="labelText">Date: </span>
        <xsl:apply-templates select="na:date" />
      </p>
      <p>
        <xsl:apply-templates select="na:synopsis" />
      </p>
      <xsl:call-template name="createLinkToArticle">
        <xsl:with-param name="articleID" select="@id" />
      </xsl:call-template>
    </article>
  </xsl:template>

  <!-- Style scores -->
  <xsl:template match="gn:scores">
    <!-- Percent decimal value -->
    <xsl:variable name="percentDecimalValue" select="sum(gn:score/gn:value) div count(gn:score/gn:value)" />

    <xsl:call-template name="completePercentHTML">
      <xsl:with-param name="decimalValue" select="$percentDecimalValue" />
      <xsl:with-param name="wrapWithHTML" select="'h1'" />
    </xsl:call-template>

      <table class="criteria">
        <xsl:apply-templates select="gn:score/gn:criteria"/>
      </table>
  </xsl:template>

  <xsl:template match="gn:scores" mode="expandButton">
    <!-- Percent decimal value -->
    <xsl:variable name="percentDecimalValue" select="sum(gn:score/gn:value) div count(gn:score/gn:value)" />

    <xsl:call-template name="completePercentHTML">
      <xsl:with-param name="decimalValue" select="$percentDecimalValue" />
      <xsl:with-param name="wrapWithHTML" select="'h1'" />
    </xsl:call-template>

    <div class="detailsClosed">
      <button class="closed" onclick="showHideParent(this)">
        <xsl:text> </xsl:text>
      </button>
      <table class="criteria">
        <xsl:apply-templates select="gn:score/gn:criteria"/>
      </table>
    </div>
  </xsl:template>

  <!-- Style featured review scores -->
  <xsl:template match="gn:scores" mode="featuredReview">
    <!-- Percent decimal value -->
    <xsl:variable name="percentDecimalValue" select="sum(gn:score/gn:value) div count(gn:score/gn:value)" />

    <xsl:call-template name="completePercentHTML">
      <xsl:with-param name="decimalValue" select="$percentDecimalValue" />
      <xsl:with-param name="wrapWithHTML" select="'h1'" />
    </xsl:call-template>
    <p>
      <xsl:apply-templates select="gn:score/gn:criteria" mode="featuredReview" />
    </p>
  </xsl:template>

  <!-- Styles review score criteria-->
  <xsl:template match="gn:criteria">
    <tr>
      <th>
        <xsl:value-of select="."  />:
      </th>
      <xsl:call-template name="completePercentHTML">
        <xsl:with-param name="decimalValue" select="../gn:value" />
        <xsl:with-param name="wrapWithHTML" select="'td'" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <!-- Style featured review score criteria -->
  <xsl:template match="gn:criteria" mode="featuredReview">
    <span class="labelText">
      <xsl:value-of select="."  />:
    </span>
    <xsl:call-template name="completePercentHTML">
      <xsl:with-param name="decimalValue" select="../gn:value" />
      <xsl:with-param name="wrapWithHTML" select="'span'" />
    </xsl:call-template>
    <!-- Break at every third criteria -->
    <xsl:if test="position() mod 3 = 0">
      <br />
    </xsl:if>
  </xsl:template>

  <!-- Template matches forItem attribute of a Review
       and styles all of the information for the releases
       listed in the attribute value-->
  <xsl:template match="@forItems">

    <xsl:variable name="gameReleaseIDs" select="." />

    <!-- forItem attribute can contain a list of release IDs
               all IDs should correspond to the same game, so we only
               need to select one of them -->
    <!-- Tokenize game release ID list to select only one,
               or select the whole list if only one exists -->
    <xsl:variable name="gameReleaseID">
      <xsl:choose>
        <!-- if contains spaces, then more than one ID in list -->
        <xsl:when test="contains($gameReleaseIDs, ' ')">
          <xsl:value-of select="substring-before($gameReleaseIDs, ' ')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$gameReleaseIDs"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <h1>
      <xsl:call-template name="gameTitle">
        <xsl:with-param name="gameReleaseID" select="$gameReleaseID" />
      </xsl:call-template>
    </h1>

    <p class="articleMiniText">
      <span class="labelText">Published by: </span>
      <xsl:call-template name="lookupGameAttributeDetails">
        <xsl:with-param name="gameReleaseID" select="$gameReleaseID" />
        <xsl:with-param name="attributeName" select="'publishers'" />
        <xsl:with-param name="keyName" select="'GamePublishers'" />
        <xsl:with-param name="contextNodeSetKey" select="'GameByRelease'" />
      </xsl:call-template>
    </p>

    <p class="articleMiniText">
      <span class="labelText">Developed by: </span>
      <xsl:call-template name="lookupGameAttributeDetails">
        <xsl:with-param name="gameReleaseID" select="$gameReleaseID" />
        <xsl:with-param name="attributeName" select="'developers'" />
        <xsl:with-param name="keyName" select="'GameDevelopers'" />
        <xsl:with-param name="contextNodeSetKey" select="'GameByRelease'" />
      </xsl:call-template>
    </p>

    <p class="articleMiniText">
      <span class="labelText">Genre: </span>
      <xsl:for-each select="$gameCatalog">
        <xsl:value-of select="translate(key('GameByRelease', $gameReleaseID)/@genres, ' ', '/')" />
      </xsl:for-each>
    </p>

    <p class="articleMiniText">
      <span class="labelText">Platform Reviewed: </span>
      <xsl:call-template name="lookupPlatformsForReviewedGames">
        <xsl:with-param name="gameReleaseIDs" select="$gameReleaseIDs" />
      </xsl:call-template>
    </p>

  </xsl:template>

  <!-- Style news article title -->
  <xsl:template match="na:title" mode="newsArticle">
    <h1>
      <xsl:value-of select="." />
    </h1>
  </xsl:template>

  <!-- Style news article title for review -->
  <xsl:template match="na:title" mode="reviewArticle">
    <h2>
      <xsl:value-of select="." />
    </h2>
  </xsl:template>

  <!-- Style article author -->
  <xsl:template match="na:author">
    <!-- If current Author element is first in the series, then insert "by" -->
    <xsl:if test="position() = 1">
      <span class="labelText">by </span>
    </xsl:if>

    <xsl:choose>
      <!-- If current Author element position is greater than the first
           and is not the last in the series, then insert a comma and a space-->
      <xsl:when test="position() > 1 and position() != last()">, </xsl:when>
      <!-- If current Author element position is greater than 1 and it is the last
           in the series, then insert ", and "-->
      <xsl:when test="position() > 1 and position() = last()">, and </xsl:when>
    </xsl:choose>
    <xsl:value-of select="." />
  </xsl:template>

  <!-- Style article date -->
  <xsl:template match="na:date">
    <xsl:call-template name="convertDate">
      <xsl:with-param name="date" select="." />
    </xsl:call-template>
  </xsl:template>

  <!-- Style article synopsis -->
  <xsl:template match="na:synopsis">
    <p>
      <xsl:value-of select="." />
    </p>
  </xsl:template>

  <!-- /* Function looks up the platforms from a list
        * of game releases associated with a review.
        * A review can list a space-separated list of game
        * release ids. This function tokenizes the list and
        * returns a list of the platforms associated with the
        * releases.
        *
        *-->
  <xsl:template name="lookupPlatformsForReviewedGames">
    <xsl:param name="gameReleaseIDs" />
    <xsl:choose>
      <!--If parameter contains spaces, then there is more than one id-->
      <xsl:when test="contains(normalize-space($gameReleaseIDs), ' ')">
        <!--Use lookup function using substring of list as id-->

        <xsl:call-template name="lookupGameAttributeDetailsCrossDoc">
          <xsl:with-param name="gameReleaseID" select="normalize-space(substring-before($gameReleaseIDs, ' '))" />
          <xsl:with-param name="attributeName" select="'platform'" />
          <xsl:with-param name="keyName" select="'Platforms'" />
          <xsl:with-param name="contextNodeSetKey" select="'Releases'" />
        </xsl:call-template>
        <!--Insert comma-->
        <xsl:text>, </xsl:text>
        <!--Recursively call lookup platforms function with remaining ids in list-->
        <xsl:call-template name="lookupPlatformsForReviewedGames">
          <xsl:with-param name="gameReleaseIDs" select="normalize-space(substring-after($gameReleaseIDs, ' '))" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!--Only one id in the function parameter so lookup data with no recursive call-->
        <xsl:call-template name="lookupGameAttributeDetailsCrossDoc">
          <xsl:with-param name="gameReleaseID" select="$gameReleaseIDs" />
          <xsl:with-param name="attributeName" select="'platform'" />
          <xsl:with-param name="keyName" select="'Platforms'" />
          <xsl:with-param name="contextNodeSetKey" select="'Releases'" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- /* Function that retrieves a game title based on the given game release id
        *
        */ -->
  <xsl:template name="gameTitle">
    <!-- Game release id parameter -->
    <xsl:param name="gameReleaseID" />

    <!-- Switch to game catalog file context -->
    <xsl:for-each select="$gameCatalog">

      <xsl:call-template name="createLinkOrTextByID">
        <xsl:with-param name="itemID" select="$gameReleaseID" />
        <xsl:with-param name="keyName" select="'GameByRelease'" />
        <xsl:with-param name="useNodeForText" select="'gc:title'" />
      </xsl:call-template>

    </xsl:for-each>

  </xsl:template>

  <!-- /* Function that retrieves game data based on the given game release id. 
        * Game element attributes containing white-space-separated lists will be
        * tokenized and used individually in the function.
        *
        */ -->
  <xsl:template name="lookupGameAttributeDetails">
    <!-- Context node key-->
    <xsl:param name="contextNodeSetKey" />
    <!-- Game release id parameter -->
    <xsl:param name="gameReleaseID" />
    <!-- Name of a game attribute containing single value or space separated list -->
    <xsl:param name="attributeName" />
    <!-- Key pointing to data elements containing details related to the items in the list -->
    <xsl:param name="keyName" />

    <!-- Switch to game catalog file context -->
    <xsl:for-each select="$gameCatalog">
      <!-- Variable holds the Game node specified by the release id -->
      <xsl:variable name="contextNodeSet" select="key($contextNodeSetKey, $gameReleaseID)" />

      <!-- Variable holding idrefs for the specified attribute of the game -->
      <xsl:variable name="itemIDList" select="$contextNodeSet//@*[name() = $attributeName]"/>

      <!-- If the item id list is empty, then there are no values for the attribute
           so insert 'N/A' text, otherwise use list in recursive call -->
      <xsl:choose>
        <xsl:when test="not($itemIDList)">
          N/A
        </xsl:when>
        <xsl:otherwise>
          <!-- Because attribute is a space-delimited list of
           id refs the following recursive function is used to
           separate the ids and locate their individual data -->
          <xsl:call-template name="lookupGameAttributeDetailsRecursive">
            <xsl:with-param name="itemIDList" select="normalize-space($itemIDList)" />
            <xsl:with-param name="keyName" select="$keyName" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:for-each>
  </xsl:template>

  <!-- /* Function that receives a list of id refs from a game attribute
        * and recursively retrieves the associated data
        *
        */ -->
  <xsl:template name="lookupGameAttributeDetailsRecursive">
    <!-- list parameter holds a list of items separated by spaces-->
    <xsl:param name="itemIDList" />
    <!-- Key pointing to detailed data related to the items in the list -->
    <xsl:param name="keyName" />

    <xsl:choose>
      <!-- If item ID list contains a space, then there is more
           than one item in the list -->
      <xsl:when test="contains(normalize-space($itemIDList), ' ')">

        <!-- Get the content of the current detail data node using key lookup and curernt itemID.
             Current item ID is retrieved using substring-before -->
        <!-- Output a link for elements with a homepage attribute 
             or text for those without a homepage attribute-->
        <xsl:call-template name="createLinkOrTextByID">
          <xsl:with-param name="itemID" select="substring-before($itemIDList, ' ')" />
          <xsl:with-param name="keyName" select="$keyName" />
        </xsl:call-template>
        <!-- Insert comma in output to separate list items -->
        <xsl:text>, </xsl:text>

        <!-- Function is called recursively with list of remaining items.
             List of remaining items is retrieved using substring-after -->
        <xsl:call-template name="lookupGameAttributeDetailsRecursive">
          <xsl:with-param name="itemIDList" select="normalize-space(substring-after($itemIDList, ' '))" />
          <xsl:with-param name="keyName" select="$keyName" />
        </xsl:call-template>
      </xsl:when>

      <!-- If list of item IDs contains no spaces, then the parameter only has one value,
           so output the single value in the function's parameter -->
      <xsl:otherwise>
        <!-- Output a link for elements with a homepage attribute 
             or text for those without a homepage attribute-->
        <xsl:call-template name="createLinkOrTextByID">
          <xsl:with-param name="itemID" select="$itemIDList" />
          <xsl:with-param name="keyName" select="$keyName" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This version of lookupGameAttributeDetails inserts
  cross document links -->
  <xsl:template name="lookupGameAttributeDetailsCrossDoc">
    <!-- Context node key-->
    <xsl:param name="contextNodeSetKey" />
    <!-- Game release id parameter -->
    <xsl:param name="gameReleaseID" />
    <!-- Name of a game attribute containing single value or space separated list -->
    <xsl:param name="attributeName" />
    <!-- Key pointing to data elements containing details related to the items in the list -->
    <xsl:param name="keyName" />

    <!-- Switch to game catalog file context -->
    <xsl:for-each select="$gameCatalog">
      <!-- Variable holds the Game node specified by the release id -->
      <xsl:variable name="contextNodeSet" select="key($contextNodeSetKey, $gameReleaseID)" />

      <!-- Variable holding idrefs for the specified attribute of the game -->
      <xsl:variable name="itemIDList" select="$contextNodeSet//@*[name() = $attributeName]"/>

      <!-- If the item id list is empty, then there are no values for the attribute
           so insert 'N/A' text, otherwise use list in recursive call -->
      <xsl:choose>
        <xsl:when test="not($itemIDList)">
          N/A
        </xsl:when>
        <xsl:otherwise>
          <!-- Because attribute is a space-delimited list of
           id refs the following recursive function is used to
           separate the ids and locate their individual data -->
          <xsl:call-template name="lookupGameAttributeDetailsCrossDocRecursive">
            <xsl:with-param name="itemIDList" select="normalize-space($itemIDList)" />
            <xsl:with-param name="keyName" select="$keyName" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:for-each>
  </xsl:template>

  <!-- This version of lookupGameAttributeDetails inserts
  cross document links -->
  <xsl:template name="lookupGameAttributeDetailsCrossDocRecursive">
    <!-- list parameter holds a list of items separated by spaces-->
    <xsl:param name="itemIDList" />
    <!-- Key pointing to detailed data related to the items in the list -->
    <xsl:param name="keyName" />

    <xsl:choose>
      <!-- If item ID list contains a space, then there is more
           than one item in the list -->
      <xsl:when test="contains($itemIDList, ' ')">

        <!-- Get the content of the current detail data node using key lookup and curernt itemID.
             Current item ID is retrieved using substring-before -->
        <!-- Output a link for elements with a homepage attribute 
             or text for those without a homepage attribute-->
        <xsl:call-template name="createLinkOrTextByIDCrossDoc">
          <xsl:with-param name="itemID" select="substring-before($itemIDList, ' ')" />
          <xsl:with-param name="keyName" select="$keyName" />
          <xsl:with-param name="fileName" select="$gamesPageName" />
        </xsl:call-template>
        <!-- Insert comma in output to separate list items -->
        <xsl:text>, </xsl:text>

        <!-- Function is called recursively with list of remaining items.
             List of remaining items is retrieved using substring-after -->
        <xsl:call-template name="lookupGameAttributeDetailsRecursive">
          <xsl:with-param name="itemIDList" select="normalize-space(substring-after($itemIDList, ' '))" />
          <xsl:with-param name="keyName" select="$keyName" />
        </xsl:call-template>
      </xsl:when>

      <!-- If list of item IDs contains no spaces, then the parameter only has one value,
           so output the single value in the function's parameter -->
      <xsl:otherwise>
        <!-- Output a link for elements with a homepage attribute 
             or text for those without a homepage attribute-->
        <xsl:call-template name="createLinkOrTextByIDCrossDoc">
          <xsl:with-param name="itemID" select="$itemIDList" />
          <xsl:with-param name="keyName" select="$keyName" />
          <xsl:with-param name="fileName" select="$gamesPageName" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- /* Function outputs a link for elements with a homepage attribute 
        * or text for those without a homepage attribute
        * using the given ID
        */-->
  <xsl:template name="createLinkOrTextByID">
    <!--ID of the item-->
    <xsl:param name="itemID" />
    <!--Name of key used to lookup the item-->
    <xsl:param name="keyName" />
    <!--Use the specified child node as link text.
         If not provided, link will use element's contents as link text -->
    <xsl:param name="useNodeForText" />

    <!--Get the element's node using key lookup-->
    <xsl:variable name="nodeLookup" select="key($keyName, $itemID)" />

    <!-- Variable text holds the text to be extracted-->
    <xsl:variable name="text">
      <xsl:choose>
        <!-- When a node has been specified in the paramter, use that node-->
        <xsl:when test="$useNodeForText">
          <xsl:value-of select="normalize-space($nodeLookup/*[$useNodeForText])" />
        </xsl:when>
        <!-- When a node has not been specified in the parameter, use the value of the looked-up node -->
        <xsl:otherwise>
          <xsl:value-of select="normalize-space($nodeLookup)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>

      <!--If the node has a homepage attribute, create a link-->
      <xsl:when test="$nodeLookup/@homepage">
        <a href="{$nodeLookup/@homepage}" target="_blank">
          <xsl:value-of select="$text" />
        </a>
      </xsl:when>

      <!--Create plain text if there is no homepage attribute-->
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This version of createLinkOrTextByID inserts
  cross document links in the format "filename.extension#id"-->
  <xsl:template name="createLinkOrTextByIDCrossDoc">
    <!--ID of the item-->
    <xsl:param name="itemID" />
    <!--Name of key used to lookup the item-->
    <xsl:param name="keyName" />
    <!--Use the specified child node as link text.
         If not provided, link will use element's contents as link text -->
    <xsl:param name="useNodeForText" />
    <xsl:param name="fileName" />

    <!--Get the element's node using key lookup-->
    <xsl:variable name="nodeLookup" select="key($keyName, $itemID)" />

    <!-- Variable text holds the text to be extracted-->
    <xsl:variable name="text">
      <xsl:choose>
        <!-- When a node has been specified in the paramter, use that node-->
        <xsl:when test="$useNodeForText">
          <xsl:value-of select="normalize-space($nodeLookup/*[$useNodeForText])" />
        </xsl:when>
        <!-- When a node has not been specified in the parameter, use the value of the looked-up node -->
        <xsl:otherwise>
          <xsl:value-of select="normalize-space($nodeLookup)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="link" select="concat($fileName, '#', $itemID)" />

    <a href="{$link}">
      <xsl:value-of select="$text" />
    </a>

  </xsl:template>

  <!-- /* Function creates a link to a full article
        * using the given article id. If the article
        * has an external link, a link is created to
        * the external page; otherwise the link is created
        * to the articles page using the id, i.e., pagename#id
        *
        */ -->
  <xsl:template name="createLinkToArticle">
    <xsl:param name="articleID" />
    <xsl:choose>
      <xsl:when test="na:externalLink">
        <xsl:apply-templates select="na:externalLink" />
      </xsl:when>
      <xsl:otherwise>
        <a href="{$articlesPageName}#{@id}" class="readMoreLink">
          <xsl:text disable-output-escaping="yes"><![CDATA[Read more &raquo;]]></xsl:text>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Style link to external article -->
  <xsl:template match="na:externalLink">
    <a href="{.}" class="readMoreLink">
      <xsl:text disable-output-escaping="yes"><![CDATA[Read more &raquo;]]></xsl:text>
    </a>
  </xsl:template>

  <xsl:template name="formatScorePercent">
    <xsl:param name="percentTotal" />
    <xsl:value-of select="format-number($percentTotal * 10, '##0')"/>
  </xsl:template>

  <xsl:template name="getScorePercentCSSColor">
    <xsl:param name="percentValue" />

    <xsl:choose>
      <xsl:when test="$percentValue >= 90">
        score90_100
      </xsl:when>
      <xsl:when test="$percentValue >= 80">
        score80_89
      </xsl:when>
      <xsl:when test="$percentValue >= 70">
        score70_79
      </xsl:when>
      <xsl:when test="$percentValue >= 60">
        score60_69
      </xsl:when>
      <xsl:when test="$percentValue >= 50">
        score50_59
      </xsl:when>
      <xsl:when test="$percentValue >= 40">
        score40_49
      </xsl:when>
      <xsl:when test="$percentValue >= 30">
        score30_39
      </xsl:when>
      <xsl:when test="$percentValue >= 20">
        score20_29
      </xsl:when>
      <xsl:when test="$percentValue >= 10">
        score10_19
      </xsl:when>
      <xsl:when test="$percentValue >= 0">
        score0_9
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="completePercentHTML">
    <xsl:param name="decimalValue" />
    <xsl:param name="wrapWithHTML" />

    <!-- Format percent before getting text color to avoid color errors
         due to rounding for example if 8.9, gets colored first and then
         rounded up to 9, then the value 90% will have the wrong color -->
    <xsl:variable name="formattedPercent">
      <xsl:call-template name="formatScorePercent">
        <xsl:with-param name="percentTotal" select="$decimalValue" />
      </xsl:call-template>
    </xsl:variable>

    <!-- Get css color value using formatted number -->
    <xsl:variable name="percentCSSClass">
      <xsl:call-template name="getScorePercentCSSColor">
        <xsl:with-param name="percentValue" select="$formattedPercent" />
      </xsl:call-template>
    </xsl:variable>

    <!-- Wrap percent output with input html tag -->
    <xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$wrapWithHTML" />
    <xsl:text disable-output-escaping="yes"> class="scorePercent </xsl:text><xsl:value-of select="$percentCSSClass"/>
    <xsl:text disable-output-escaping="yes">"></xsl:text>
    <xsl:value-of select="$formattedPercent" />%
    <xsl:text disable-output-escaping="yes">&lt;/</xsl:text><xsl:value-of select="$wrapWithHTML" /><xsl:text disable-output-escaping="yes">></xsl:text>
  </xsl:template>

</xsl:stylesheet>
