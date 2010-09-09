
// ConfigurationManagementFactory.java --
//
// ConfigurationManagementFactory.java is part of ElectricCommander.
//
// Copyright (c) 2005-2010 Electric Cloud, Inc.
// All rights reserved.
//

package ecplugins.esx.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.JavaScriptObject;

import com.electriccloud.commander.gwt.client.ComponentBase;
import com.electriccloud.commander.gwt.client.ComponentBaseFactory;
import com.electriccloud.commander.gwt.client.FormBase;
import com.electriccloud.commander.gwt.client.PropertySheetEditor;

import static com.electriccloud.commander.gwt.client.util.CommanderUrlBuilder.createPageUrl;


public class ConfigurationManagementFactory
    extends ComponentBaseFactory
    implements EntryPoint
{

    //~ Methods ----------------------------------------------------------------

    @Override public void onCommanderInit(String divId, JavaScriptObject jso)
    {
        String        panel     = getParameter(jso, "panel");
        ComponentBase component;

        if ("create".equals(panel)) {
            component = new CreateConfiguration();
        }
        else if ("edit".equals(panel)) {
            String configName    = getGetParameter("configName");
            String propSheetPath = "/plugins/" + getPluginName()
                + "/project/esx_cfgs/" + configName;
            String formXmlPath   = "/plugins/" + getPluginName()
                + "/project/ui_forms/ESXEditConfigForm";

            component = new PropertySheetEditor("ecgc",
                    "Edit ESX Configuration", configName,
                    propSheetPath, formXmlPath, getPluginName());

            ((FormBase) component).setDefaultRedirectToUrl(createPageUrl(
                    getPluginName(), "configurations")
                    .buildString());
        }
        else {

            // Default panel is "list"
            component = new ConfigurationList();
        }

        renderIntoDiv(divId, jso, component);
    }
}
