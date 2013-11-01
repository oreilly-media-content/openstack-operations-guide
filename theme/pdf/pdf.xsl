<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="exsl h">

<!-- Drop hard pagebreak PIs from OpenStack source -->
<xsl:template match="processing-instruction()[contains(name(), 'hard-pagebreak')]"/>

<!-- Insert revision table at revhistory PI -->
<xsl:template match="processing-instruction('rax')[normalize-space(.) = 'revhistory']">
    <table>
      <thead>
        <tr>
          <td>Revision Date</td>
          <td>Summary of Changes</td>
        </tr>
      </thead>
      <tbody>
      <tr>
        <td>
          <p>2013-05-13</p>
        </td>
        <td>
          <p>Updated description of availability zones.</p>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-04-02</p>
        </td>
        <td>
          <p>Fixes to ensure samples fit in page size and notes are formatted.</p>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-22</p>
        </td>
        <td>
          <p>Stopped chunking in HTML output.</p>
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
          <p>Moved files to OpenStack github repository.</p>
        </td>
      </tr>
      </tbody>
   </table>
</xsl:template>

</xsl:stylesheet>
