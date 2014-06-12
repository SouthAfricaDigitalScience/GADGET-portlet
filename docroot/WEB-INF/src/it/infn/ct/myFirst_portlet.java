/**
 * ************************************************************************
 * Copyright (c) 2011: Istituto Nazionale di Fisica Nucleare (INFN), Italy
 * Consorzio COMETA (COMETA), Italy
 *
 * See http://www.infn.it and and http://www.consorzio-cometa.it for details on
 * the copyright holders.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * @author <a href="mailto:riccardo.bruno@ct.infn.it">Riccardo Bruno</a>(COMETA)
 * **************************************************************************
 */
package it.infn.ct;

//import javax.portlet.*;
// Importing liferay libraries
import java.io.IOException;
import javax.portlet.*;


public class myFirst_portlet extends GenericPortlet {

    // This portlet uses Aciont/Views enumerations in order to 
    // manage the different portlet modes and the corresponding 
    // view to display
    // You may override the current values with your own business
    // logic best identifiers and manage them through: jsp and java code
    // The jsp parameter PortletStatus will be the responsible of
    // portlet mode switching. This parameter will be read by
    // the processAction method who will select the proper view mode
    // registering again into 'PortletStatus' renderResponse parameter
    // the next view mode.
    // The default prortlet mode by default is: ACTION_INPUT (see ProcessAction)
    private enum Actions {

        ACTION_INPUT // Called before to show the INPUT view
        , ACTION_SUBMIT   // Called after the user press the submit button    
    }

    private enum Views {

        VIEW_INPUT // View containing application input field
        , VIEW_SUBMIT     // View reporting input value    
        ,VIEW_NO_ACTION
    }

    // The init values will be read form portlet.xml from <init-param> xml tag
    // This tag will be useful to setup defaults values for your own portlet
    class App_Init {

        String default_prefvalue;

        public App_Init() {
            default_prefvalue = "";
        }
    } // App_Init
    // Instanciate the App_Init object
    public App_Init appInit = new App_Init();

    //
    // Application input values
    //
    class App_Input {

        String inputValue;   //Text for application input field

        public App_Input() {

            inputValue = "";
        }
    } // App_Input

    class App_Preferences {

        String pref_value;

        public App_Preferences() {
            pref_value = "";
        }
    }
    public App_Preferences appPreferences = new App_Preferences();
    // Liferay portlet data        
    PortletSession portletSession;  // PorteltSession
    PortletContext portletContext;  // PortletContext
    public String appServerPath;   // This variable stores the absolute path of the Web applications
    // Other misc valuse
    // (!) Pay attention that altough the use of the LS variable
    //     the replaceAll("\n","") has to be used 
    public String LS = System.getProperty("line.separator");

    //
    // Portlet Methods
    // 
    //
    // init
    //
    // The init method will be called when installing the portlet for the first time 
    // This is the right time to get default values from WEBINF/portlet.xml file
    // Those values will be assigned into parameters the first time the processAction
    // will be called thanks to the appPreferences object
    //
    @Override
    public void init()
            throws PortletException {
        // Load default values from portlet.xml              
        appInit.default_prefvalue = getInitParameter("prefItem");
    } // init

    //
    // processAction
    //
    // This method allows the portlet to process an action request; this method is normally
    // called upon each user interaction (a submit button inside a jsp' <form statement)
    //
    @Override
    public void processAction(ActionRequest request, ActionResponse response)
            throws PortletException, IOException {
        System.out.println("calling processAction ...");

        // Determine the application pathname                
        portletSession = request.getPortletSession();
        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        System.out.println("Web Application path: '" + appServerPath + "'");

        // Determine the current portlet mode and forward this state to the response
        // Accordingly to JSRs168/286 the standard portlet modes are:
        // VIEW, EDIT, HELP
        PortletMode mode = request.getPortletMode();
        response.setPortletMode(request.getPortletMode());

        // Switch among different portlet modes: VIEW, EDIT, HELP
        // Custom modes are not covered by this template
        if (mode.equals(PortletMode.VIEW)) {
            // The VIEW mode is the normal portlet mode where normal portlet
            // content will be shown to the user
            System.out.println("Portlet mode: VIEW");

            // The actionStatus value will be taken from the calling jsp file
            // through the 'PortletStatus' parameter; the corresponding
            // VIEW mode will be stored registering the portlet status
            // as render parameter. See the call to setRenderParameter
            // If the actionStatus parameter is null or empty the default
            // action will be the ACTION_INPUT (input form)
            // This happens the first time the portlet is shown
            // The PortletStatus variable is managed by jsp and this java code
            String actionStatus = request.getParameter("PortletStatus");
            // Assigns the default ACTION
            if (null == actionStatus
                    || actionStatus.equals("")) {
                actionStatus = "" + Actions.ACTION_INPUT;
            }

            // Different actions will be performed accordingly to the
            // different possible statuses
            switch (Actions.valueOf(actionStatus)) {
                case ACTION_INPUT:
                    System.out.println("Got action: 'ACTION_INPUT'");

                    // Assign the correct view
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
                    break;
                case ACTION_SUBMIT:
                    System.out.println("Got action: 'ACTION_SUBMIT'");



                    // Create the appInput object
                    App_Input appInput = new App_Input();



                    // Process input field
                    getInputForm(request, appInput);



                    // Send the inputValue and assign the correct view                    
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_SUBMIT);

                    response.setRenderParameter("inputValue", "" + appInput.inputValue);
                    break;
                default:
                    System.out.println("Unhandled action: '" + actionStatus + "'");
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
            }
        } else if (mode.equals(PortletMode.HELP)) {
            // The HELP mode used to give portlet usage HELP to the user
            // This code will be called after the call to doHelp method                         
            System.out.println("Portlet mode: HELP");
        } else if (mode.equals(PortletMode.EDIT)) {
             System.out.println("Portlet mode: EDIT");
            // The EDIT mode is used to view/setup portlet preferences
            PortletPreferences portletPreferences = request.getPreferences();

           
            String old_pref_value = portletPreferences.getValue("prefItem", appInit.default_prefvalue);
            String new_pref_value = request.getParameter("pref_value");
            
             response.setRenderParameter("pref_value", "" + new_pref_value);
             appPreferences.pref_value=new_pref_value;
            // request.setAttribute("pref_value", new_pref_value);
            portletPreferences.setValue("pref_value", new_pref_value);
        } else {
            // Unsupported portlet modes come here
            System.out.println("Custom portlet mode: '" + mode.toString() + "'");
        }
    } // processAction

    //
    // Method responsible to show portlet content to the user accordingly to the current view mode
    //
    @Override
    protected void doView(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        System.out.println("calling doView ...");
        response.setContentType("text/html");


        PortletPreferences portletPreferences = request.getPreferences();
        
        
      

        
        appPreferences.pref_value = portletPreferences.getValue("pref_value", appPreferences.pref_value);
        if (appPreferences.pref_value.equals(null)  || appPreferences.pref_value.equals("")) {
            
            
            appPreferences.pref_value = appInit.default_prefvalue;
            
            portletPreferences.setValue("pref_value",  appPreferences.pref_value);
        }

        // Determine the application pathname                
        portletSession = request.getPortletSession();
        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        System.out.println("Web Application path: '" + appServerPath + "'");

        // Switch among supported views; the currentView is determined by the
        // portlet render parameter value stored into PortletStatus identifier
        // this value has been assigned by the actionStatus or it will be 
        // null in case the doView method will be called without a
        // previous processAction call; in such a case the default VIEW_INPUT
        // will be selected.
        //The PortletStatus variable is managed by jsp and this java code
        String currentView = request.getParameter("PortletStatus");
        if (null == currentView
                || currentView.equals("")) {
            currentView = "" + Views.VIEW_INPUT;
        }

        // Different actions will be performed accordingly to the
        // different possible view modes
        switch (Views.valueOf(currentView)) {
            // The following code is responsible to call the proper jsp file
            // that will provide the correct portlet interface
            case VIEW_INPUT: {
                System.out.println("VIEW_INPUT Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/input.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_SUBMIT: {
                System.out.println("VIEW_SUBMIT Selected ...");

                String inputValue = request.getParameter("inputValue");

                request.setAttribute("inputValue", inputValue);
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/submit.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_NO_ACTION:{
                System.out.println("VIEW_NO_ACTION Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/view_without_action.jsp");
                dispatcher.include(request, response); 
            }
            break;    
            default:
                System.out.println("Unknown view mode: " + currentView.toString());
        } // switch            
    } // doView

    //
    // doEdit
    //
    // This methods prepares an actionURL that will be used by edit.jsp file into a <input ...> form
    // As soon the user press the action button the processAction will be called and the portlet mode
    // will be set as EDIT.
    @Override
    public void doEdit(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
       
       
        PortletPreferences portletPreferences = request.getPreferences();
      
		 System.out.println("calling doEdit ...");
       
       // PortletPreferences portletPreferences = request.getPreferences();
        request.setAttribute("pref_value", appPreferences.pref_value);
       
        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/edit.jsp");
        dispatcher.include(request, response);

    } // doEdit

    //
    // doHelp
    //
    // This method just calls the jsp responsible to show the portlet information
    @Override
    public void doHelp(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        response.setContentType("text/html");
        System.out.println("calling doHelp ...");
        //request.setAttribute("portletVersion", appInit.portletVersion);
        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/help.jsp");
        dispatcher.include(request, response);
    } // doHelp

    //
    // getInputForm (method)
    //
    public void getInputForm(ActionRequest request, App_Input appInput) {

        // Retrieve from the input form the given application values
        appInput.inputValue = (String) request.getParameter("inputValue");

        // Show into the log the taken inputs
        System.out.println(
                LS + "Taken input parameters:"
                + LS + "-----------------------"
                + LS + "myValue: '" + appInput.inputValue + "'"
                + LS);
    } // getInputForm 
} // myFirst_portlet 
