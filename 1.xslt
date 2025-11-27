<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="teacher-name" select="'Борисов И.О.'"/>
    <xsl:param name="xml-topic"    select="'XML'"/>
    <xsl:param name="xslt-topic"   select="'XSLT'"/>

    <xsl:output method="html" encoding="UTF-8" />

    <xsl:key name="coursesByTeacher"
             match="course"
             use="teachers/teacher"/>

    <xsl:key name="coursesByKeyword"
             match="course"
             use="keywords/keyword"/>

    <xsl:template match="/">
        <html>
        <head>
            <title>Наши курсы</title>
        </head>
        <body>
            <h1>Наши курсы</h1>

            <h3>Курсы, которые читает <xsl:value-of select="$teacher-name"/></h3>
            <ul>
                <xsl:apply-templates
                    select="key('coursesByTeacher', $teacher-name)"/>
            </ul>

            <h3>Курсы, которые используют <xsl:value-of select="$xml-topic"/></h3>
            <ul>
                <xsl:apply-templates
                    select="key('coursesByKeyword', $xml-topic)"/>
            </ul>

            <h3>Курсы, которые читает <xsl:value-of select="$teacher-name"/>
                и в которых есть тема <xsl:value-of select="$xslt-topic"/></h3>
            <ul>
                <xsl:apply-templates
                    select="key('coursesByTeacher', $teacher-name)
                            [keywords/keyword = $xslt-topic]"/>
            </ul>
        </body>
        </html>
    </xsl:template>

    <xsl:template match="course">
        <li>
            <xsl:value-of select="normalize-space(title)"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
