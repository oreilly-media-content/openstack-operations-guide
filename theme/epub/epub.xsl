<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="h">

<!-- Pull in EPUB ad -->

<xsl:template match="h:body[contains(@data-type, 'book')]">
 <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:copy-of select="document('theme/ad.html')"/>
   <xsl:copy-of select="node()"/>
 </xsl:copy>
</xsl:template>

<!-- Pull in O'Reilly copyright page info -->
<xsl:template match="h:section[contains(@data-type, 'copyright-page')]">
    <xsl:copy-of select="document('theme/pdf/copyright.html')"/>
</xsl:template>

<!-- Pull in author name from OpenStack source -->
<xsl:template match="h:section[contains(@data-type, 'titlepage')]/h:h2">
 <h2>
   <xsl:attribute name="data-type">author</xsl:attribute>
   <xsl:copy-of select="document('theme/pdf/copyright.html')//h:p[@class='author']"/>
 </h2>
</xsl:template>   

<!-- Drop hard pagebreak PIs from OpenStack source -->
<xsl:template match="processing-instruction()[contains(name(), 'hard-pagebreak')]"/>

<!-- Insert revision table at revhistory PI -->
<xsl:template match="processing-instruction('rax')[normalize-space(.) = 'revhistory']">
    <table>
      <thead>
        <tr>
          <th>Revision Date</th>
          <th>Summary of Changes</th>
        </tr>
      </thead>
      <tbody>
      <tr>
        <td>
          <p>2013-05-13</p>
        </td>
        <td>
          <ul>
            <li><p>Updated description of availability zones.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-04-02</p>
        </td>
        <td>
          <ul>
            <li><p>Fixes to ensure samples fit in page size and notes are formatted.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-22</p>
        </td>
        <td>
          <ul>
            <li><p>Stopped chunking in HTML output.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-20</p>
        </td>
        <td>
          <ul>
            <li><p>Editorial changes.</p></li>
            <li><p>Added <code>glossterm</code> tags to glossary terms.</p></li>
            <li><p>Cleaned up formatting in code examples.</p></li>
            <li><p>Removed future tense.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-11</p>
        </td>
        <td>
          <ul>
            <li><p>Moved files to OpenStack github repository.</p></li>
          </ul>
        </td>
      </tr>
      </tbody>
   </table>
</xsl:template>

</xsl:stylesheet>
