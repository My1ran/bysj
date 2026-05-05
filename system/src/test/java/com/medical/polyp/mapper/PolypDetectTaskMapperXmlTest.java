package com.medical.polyp.mapper;

import static org.junit.Assert.assertNotEquals;

import java.io.File;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class PolypDetectTaskMapperXmlTest
{
    @Test
    public void dashboardRecentTasksDoesNotForceIntegerParameterType() throws Exception
    {
        Element select = selectStatement("selectDashboardRecentTasks");

        assertNotEquals("java.lang.Integer", select.getAttribute("parameterType"));
    }

    private Element selectStatement(String id) throws Exception
    {
        File mapperFile = new File("src/main/resources/mapper/polyp/PolypDetectTaskMapper.xml");
        Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(mapperFile);
        NodeList selectNodes = document.getElementsByTagName("select");
        for (int i = 0; i < selectNodes.getLength(); i++)
        {
            Element select = (Element) selectNodes.item(i);
            if (id.equals(select.getAttribute("id")))
            {
                return select;
            }
        }
        throw new AssertionError("select statement not found: " + id);
    }
}
