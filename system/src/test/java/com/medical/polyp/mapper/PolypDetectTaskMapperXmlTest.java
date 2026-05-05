package com.medical.polyp.mapper;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;

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

    @Test
    public void dashboardStatementsUseOptionalUserScope() throws Exception
    {
        assertHasOptionalUserScope("selectDashboardOverview");
        assertHasOptionalUserScope("selectDashboardTrend");
        assertHasOptionalUserScope("selectDashboardMediaDistribution");
        assertHasOptionalUserScope("selectDashboardStatusDistribution");
        assertHasOptionalUserScope("selectDashboardRecentTasks");
    }

    private void assertHasOptionalUserScope(String id) throws Exception
    {
        Element select = selectStatement(id);
        NodeList ifNodes = select.getElementsByTagName("if");

        boolean hasGuard = false;
        for (int i = 0; i < ifNodes.getLength(); i++)
        {
            Element ifNode = (Element) ifNodes.item(i);
            if ("userId != null".equals(ifNode.getAttribute("test")))
            {
                hasGuard = true;
                break;
            }
        }

        assertTrue(id + " should guard user scope with a null check", hasGuard);
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
