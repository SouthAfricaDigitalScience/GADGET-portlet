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
 * @author <a href="https://github.com/brucellino">Bruce Becker</a> (CSIR)
 * **************************************************************************
 */
package it.infn.ct;

//import javax.portlet.*;
// Importing liferay libraries
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import javax.portlet.*;

public class GADGET_portlet extends GenericPortlet {

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
        , ACTION_SUBMIT_MUSIC // Called after the user press the submit button    
        , ACTION_SUBMIT_GADGET_MAKEFILE
        , ACTION_SUBMIT_GADGET_PARAM
        ,ACTION_SUBMIT
    }

    private enum Views {

         VIEW_INPUT // View containing application input field
        , VIEW_SUBMIT_MUSIC // View reporting input value 
        , VIEW_SUBMIT_GADGET_MAKEFILE, VIEW_NO_ACTION
        ,VIEW_SUBMIT_GADGET_PARAM
        ,VIEW_SUBMIT
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

        /**
         * ******INPUT SETUP VALUES*******
         */
        String boxlength;
        String zstart;
        String levelmin;
        String levelmin_TF;
        String levelmax;
        String padding;
        String overlap;
        String ref_center;
        String ref_extent;
        String ref_offset;
        String align_top;
        String baryons;
        String use_2LPT;
        String periodic_TF;
        /**
         * ******INPUT COSMOLOGY VALUES*******
         */
        String omega_m;
        String omega_L;
        String omega_b;
        String H0;
        String sigma_8;
        String nspec;
        String transfer;
        /**
         * ******INPUT RANDOM VALUES*******
         */
        String seed7;
        String seed8;
        String seed9;
        String seed10;
        String seed11;
        String seed12;
        /**
         * ******INPUT POISSON VALUES*******
         */
        String fft_fine;
        String accuracy;
        String pre_smooth;
        String post_smooth;
        String smoother;
        String laplace_order;
        String grad_order;

        public App_Input() {

            boxlength = zstart = levelmin = levelmin_TF = levelmax = padding = overlap = ref_center = ref_extent = ref_offset = align_top = baryons = use_2LPT = periodic_TF = "";
            omega_m = omega_L = omega_b = H0 = sigma_8 = nspec = transfer = "";
            seed7 = seed8 = seed9 = seed10 = seed11 = seed12 = "";
            fft_fine = accuracy = pre_smooth = post_smooth = smoother = laplace_order = grad_order = "";

        }
    } // App_Input

    class App_InputGADGET {

        boolean PERIODIC;
        boolean UNEQUALSOFTENINGS;
        boolean PEANOHILBERT;
        boolean WALLCLOCK;
        boolean PMGRID;
        String PLACEHIGHRESREGION;
        String ENLARGEREGION;
        String ASMTH;
        String RCUT;
        boolean DOUBLEPRECISION;
        boolean DOUBLEPRECISION_FFTW;
        boolean SYNCHRONIZATION;
        boolean FLEXSTEPS;
        boolean PSEUDOSYMMETRIC;
        boolean NOSTOP_WHEN_BELOW_MINTIMESTEP;
        boolean NOPMSTEPADJUSTMENT;
        boolean HAVE_HDF5;
        boolean OUTPUTPOTENTIAL;
        boolean OUTPUTACCELERATION;
        boolean OUTPUTCHANGEOFENTROPY;
        boolean OUTPUTTIMESTEP;
        boolean NOGRAVITY;
        boolean NOTREERND;
        boolean NOTYPEPREFIX_FFTW;
        boolean LONG_XYZ;
        boolean TWODIMS;
        boolean SPH_BND_PARTICLES;
        boolean NOVISCOSITYLIMITER;
        boolean COMPUTE_POTENTIAL_ENERGY;
        boolean LONGIDS;
        boolean ISOTHERMAL;
        boolean SELECTIVE_NO_GRAVITY;
        String FORCETEST;
        boolean MAKEGLASS;

        public App_InputGADGET() {

            PERIODIC = UNEQUALSOFTENINGS = PEANOHILBERT = WALLCLOCK = PMGRID = DOUBLEPRECISION = DOUBLEPRECISION_FFTW = SYNCHRONIZATION = FLEXSTEPS = PSEUDOSYMMETRIC = NOSTOP_WHEN_BELOW_MINTIMESTEP = NOPMSTEPADJUSTMENT = HAVE_HDF5 = OUTPUTPOTENTIAL = OUTPUTACCELERATION = OUTPUTCHANGEOFENTROPY = OUTPUTTIMESTEP = NOGRAVITY = NOTREERND = NOTYPEPREFIX_FFTW = LONG_XYZ = TWODIMS = SPH_BND_PARTICLES = NOVISCOSITYLIMITER = COMPUTE_POTENTIAL_ENERGY = LONGIDS = ISOTHERMAL = SELECTIVE_NO_GRAVITY = MAKEGLASS = false;
            PLACEHIGHRESREGION = ENLARGEREGION = ASMTH = RCUT = FORCETEST = "";

        }
    }

     class App_InputGADGET_PARAM {
     
         String OutputDir;
         String SnapshotFileBase;       
         String SnapFormat;
         String NumFilesPerSnapshot;
         String InitCondFile;
         String ICFormat;
         String RestartFile;
         String InfoFile;         
         String TimingsFile;       
         String CpuFile;
         String EnergyFile;
         String TimeLimitCPU;       
         String ResubmitCommand;       
         String ResubmitOn;
         String CpuTimeBetRestartFile;
         String TimeBegin;
         String TimeMax;
         String BoxSize;
         String PeriodicBoundariesOn;
         String ComovingIntegrationOn;        
         String HubbleParam;
         String Omega0;
         String OmegaLambda;
         String OmegaBaryon;
                 
                 
         public App_InputGADGET_PARAM() {
             OutputDir=SnapshotFileBase=SnapFormat=NumFilesPerSnapshot=InitCondFile=ICFormat=RestartFile=InfoFile=TimingsFile=TimingsFile=CpuFile=EnergyFile=TimeLimitCPU=ResubmitCommand=ResubmitOn=CpuTimeBetRestartFile=TimeBegin=TimeMax=BoxSize=PeriodicBoundariesOn=ComovingIntegrationOn=HubbleParam=Omega0=OmegaLambda=OmegaBaryon="";
         }
     }
    
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
                case ACTION_SUBMIT_MUSIC:
                    System.out.println("Got action: 'ACTION_SUBMIT'");



                    // Create the appInput object
                    App_Input appInput = new App_Input();



                    // Process input field
                    getInputForm(request, appInput);

                    createMUSICconfigFile(appInput);

                    // Send the inputValue and assign the correct view                    
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_SUBMIT_MUSIC);

                    //response.setRenderParameter("inputValue", "" + appInput.inputValue);
                    break;

                case ACTION_SUBMIT_GADGET_MAKEFILE:
                    System.out.println("Got action: 'ACTION_SUBMIT_GADGET_MAKEFILE'");



                    // Create the appInput object
                    App_InputGADGET appInputGADGET = new App_InputGADGET();



                    // Process input field
                    getInputFormGADGET(request, appInputGADGET);

                    createGADGET_MAKEFILE(appInputGADGET);

                    // Send the inputValue and assign the correct view                    
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_SUBMIT_GADGET_MAKEFILE);

                    //response.setRenderParameter("inputValue", "" + appInput.inputValue);
                    break;
                     case ACTION_SUBMIT_GADGET_PARAM:
                    System.out.println("Got action: 'ACTION_SUBMIT_GADGET_PARAM'");



                    // Create the appInput object
                    App_InputGADGET_PARAM appInputGADGET_PARAM = new App_InputGADGET_PARAM();



                    // Process input field
                    getInputFormGADGET_PARAM(request, appInputGADGET_PARAM);

                    createGADGET_PARAM(appInputGADGET_PARAM);

                    // Send the inputValue and assign the correct view                    
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_SUBMIT);

                    //response.setRenderParameter("inputValue", "" + appInput.inputValue);
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
            appPreferences.pref_value = new_pref_value;
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
        if (appPreferences.pref_value.equals(null) || appPreferences.pref_value.equals("")) {


            appPreferences.pref_value = appInit.default_prefvalue;

            portletPreferences.setValue("pref_value", appPreferences.pref_value);
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
            case VIEW_SUBMIT_MUSIC: {
                System.out.println("VIEW_SUBMIT_MUSIC Selected ...");

                String inputValue = request.getParameter("inputValue");

                // request.setAttribute("inputValue", inputValue);
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/inputGadgetMAKEFILE.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_SUBMIT_GADGET_MAKEFILE: {
                System.out.println("VIEW_SUBMIT_GADGET_MAKEFILE Selected ...");

                String inputValue = request.getParameter("inputValue");

                // request.setAttribute("inputValue", inputValue);
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/inputGadgetPARAM.jsp");
                dispatcher.include(request, response);
            }
            break;    
                
            case VIEW_SUBMIT: {
                System.out.println("VIEW_SUBMIT Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/submit.jsp");
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

        /**
         * ****** RETRIVE INPUT SETUP VALUES*******
         */
        appInput.boxlength = (String) request.getParameter("boxlength");
        appInput.zstart = (String) request.getParameter("zstart");
        appInput.levelmin = (String) request.getParameter("levelmin");
        appInput.levelmin_TF = (String) request.getParameter("levelmin_TF");
        appInput.levelmax = (String) request.getParameter("levelmax");
        appInput.padding = (String) request.getParameter("padding");
        appInput.overlap = (String) request.getParameter("overlap");
        appInput.ref_center = (String) request.getParameter("ref_center");
        appInput.ref_extent = (String) request.getParameter("ref_extent");
        appInput.ref_offset = (String) request.getParameter("ref_offset");
        appInput.align_top = (String) request.getParameter("align_top");
        appInput.baryons = (String) request.getParameter("baryons");
        appInput.use_2LPT = (String) request.getParameter("use_2LPT");
        appInput.periodic_TF = (String) request.getParameter("periodic_TF");

        /**
         * ******RETRIVE INPUT COSMOLOGY VALUES******
         */
        appInput.omega_m = (String) request.getParameter("omega_m");
        appInput.omega_L = (String) request.getParameter("omega_L");
        appInput.omega_b = (String) request.getParameter("omega_b");
        appInput.H0 = (String) request.getParameter("H0");
        appInput.sigma_8 = (String) request.getParameter("sigma_8");
        appInput.nspec = (String) request.getParameter("nspec");
        appInput.transfer = (String) request.getParameter("transfer");

        /**
         * ******RETRIVE INPUT RANDOM VALUES*******
         */
        appInput.seed7 = (String) request.getParameter("seed7");
        appInput.seed8 = (String) request.getParameter("seed8");
        appInput.seed9 = (String) request.getParameter("seed9");
        appInput.seed10 = (String) request.getParameter("seed10");
        appInput.seed11 = (String) request.getParameter("seed11");
        appInput.seed12 = (String) request.getParameter("seed12");


        /**
         * ****** RETRIVE INPUT POISSON VALUES*******
         */
        appInput.fft_fine = (String) request.getParameter("fft_fine");
        appInput.accuracy = (String) request.getParameter("accuracy");
        appInput.pre_smooth = (String) request.getParameter("pre_smooth");
        appInput.post_smooth = (String) request.getParameter("post_smooth");
        appInput.smoother = (String) request.getParameter("smoother");
        appInput.laplace_order = (String) request.getParameter("laplace_order");
        appInput.grad_order = (String) request.getParameter("grad_order");






        // Show into the log the taken inputs
        System.out.println(
                LS + "Taken input parameters:"
                + LS + "-----------SETUP------------"
                + LS + "boxlength: '" + appInput.boxlength + "'"
                + LS + "zstart: '" + appInput.zstart + "'"
                + LS + "levelmin: '" + appInput.levelmin + "'"
                + LS + "levelmin_TF: '" + appInput.levelmin_TF + "'"
                + LS + "levelmax: '" + appInput.levelmax + "'"
                + LS + "padding: '" + appInput.padding + "'"
                + LS + "overlap: '" + appInput.overlap + "'"
                + LS + "ref_center: '" + appInput.ref_center + "'"
                + LS + "ref_extent: '" + appInput.ref_extent + "'"
                + LS + "ref_offset: '" + appInput.ref_offset + "'"
                + LS + "align_top: '" + appInput.align_top + "'"
                + LS + "baryons: '" + appInput.baryons + "'"
                + LS + "use_2LPT: '" + appInput.use_2LPT + "'"
                + LS + "periodic_TF: '" + appInput.periodic_TF + "'"
                + LS + "\n-----------COSMOLOGY------------"
                + LS + "omega_m: '" + appInput.omega_m + "'"
                + LS + "omega_L: '" + appInput.omega_L + "'"
                + LS + "omega_b: '" + appInput.omega_b + "'"
                + LS + "H0: '" + appInput.H0 + "'"
                + LS + "sigma_8: '" + appInput.sigma_8 + "'"
                + LS + "nspec: '" + appInput.nspec + "'"
                + LS + "transfer: '" + appInput.transfer + "'"
                + LS + "\n-----------RANDOM------------"
                + LS + "seed7: '" + appInput.seed7 + "'"
                + LS + "seed8: '" + appInput.seed8 + "'"
                + LS + "seed9: '" + appInput.seed9 + "'"
                + LS + "seed10: '" + appInput.seed10 + "'"
                + LS + "seed11: '" + appInput.seed11 + "'"
                + LS + "seed12: '" + appInput.seed12 + "'"
                + LS + "transfer: '" + appInput.transfer + "'"
                + LS + "\n-----------POISSON------------"
                + LS + "fft_fine: '" + appInput.fft_fine + "'"
                + LS + "accuracy: '" + appInput.accuracy + "'"
                + LS + "pre_smooth: '" + appInput.pre_smooth + "'"
                + LS + "post_smooth: '" + appInput.post_smooth + "'"
                + LS + "smoother: '" + appInput.smoother + "'"
                + LS + "laplace_order: '" + appInput.laplace_order + "'"
                + LS + "grad_order: '" + appInput.grad_order + "'"
                + LS);
    } // getInputForm 

    public void getInputFormGADGET(ActionRequest request, App_InputGADGET appInputGADGET) {

        // Retrieve from the input form the given application values



        /**
         * ****** RETRIVE INPUT GADGET VALUES FOR MAKEFILE*******
         */
        // We first have to do checks on the boolean variables and convert them
        // to booleans from strings
        System.out.println("V1 " + request.getParameter("PLACEHIGHRESREGION") + " V2 " + request.getParameter("ASMTH"));
        if (request.getParameter("PERIODIC") != null) {
            if (request.getParameter("PERIODIC").equals("true")) {
                appInputGADGET.PERIODIC = true;
            }
        } else {
            appInputGADGET.PERIODIC = false;
        }


        if (request.getParameter("UNEQUALSOFTENINGS") != null) {
            if (request.getParameter("UNEQUALSOFTENINGS").equals("true")) {
                appInputGADGET.UNEQUALSOFTENINGS = true;
            }

        } else {
            appInputGADGET.UNEQUALSOFTENINGS = false;
        }

        if (request.getParameter("PEANOHILBERT") != null) {
            if (request.getParameter("PEANOHILBERT").equals("true")) {
                appInputGADGET.PEANOHILBERT = true;
            }

        } else {
            appInputGADGET.PEANOHILBERT = false;
        }


        if (request.getParameter("WALLCLOCK") != null) {
            if (request.getParameter("WALLCLOCK").equals("true")) {
                appInputGADGET.WALLCLOCK = true;
            }
        } else {
            appInputGADGET.WALLCLOCK = false;
        }


        if (request.getParameter("PMGRID") != null) {
            if (request.getParameter("PMGRID").equals("true")) {
                appInputGADGET.PMGRID = true;
            }
        } else {
            appInputGADGET.PMGRID = false;
        }

        if (request.getParameter("PLACEHIGHRESREGION") != null) {
            appInputGADGET.PLACEHIGHRESREGION = (String) request.getParameter("PLACEHIGHRESREGION");
        } else {
            appInputGADGET.PLACEHIGHRESREGION = "";
        }
        
        System.out.println("VAL " +appInputGADGET.PLACEHIGHRESREGION ); 

        if (request.getParameter("ENLARGEREGION") != null) {
            appInputGADGET.ENLARGEREGION = (String) request.getParameter("ENLARGEREGION");
        } else {
            appInputGADGET.ENLARGEREGION = "";
        }

        if (request.getParameter("ASMTH") != null) {
            appInputGADGET.ASMTH = (String) request.getParameter("ASMTH");
        } else {
            appInputGADGET.ASMTH = "";
        }

        if ((String) request.getParameter("RCUT") != null) {
            appInputGADGET.RCUT = (String) request.getParameter("RCUT");
        } else {
            appInputGADGET.RCUT = "";
        }


        if (request.getParameter("DOUBLEPRECISION") != null) {
            if (request.getParameter("DOUBLEPRECISION").equals("true")) {
                appInputGADGET.DOUBLEPRECISION = true;
            }
        } else {
            appInputGADGET.DOUBLEPRECISION = false;
        }

        if (request.getParameter("DOUBLEPRECISION_FFTW") != null) {
            if (request.getParameter("DOUBLEPRECISION_FFTW").equals("true")) {
                appInputGADGET.DOUBLEPRECISION_FFTW = true;
            }
        } else {
            appInputGADGET.DOUBLEPRECISION_FFTW = false;
        }


        if (request.getParameter("SYNCHRONIZATION") != null) {
            if (request.getParameter("SYNCHRONIZATION").equals("true")) {
                appInputGADGET.SYNCHRONIZATION = true;
            }
        } else {
            appInputGADGET.SYNCHRONIZATION = false;
        }

        if (request.getParameter("FLEXSTEPS") != null) {
            if (request.getParameter("FLEXSTEPS").equals("true")) {
                appInputGADGET.FLEXSTEPS = true;
            }

        } else {
            appInputGADGET.FLEXSTEPS = false;
        }
        if (request.getParameter("PSEUDOSYMMETRIC") != null) {
            if (request.getParameter("PSEUDOSYMMETRIC").equals("true")) {
                appInputGADGET.PSEUDOSYMMETRIC = true;
            }

        } else {
            appInputGADGET.PSEUDOSYMMETRIC = false;
        }



        if (request.getParameter("NOSTOP_WHEN_BELOW_MINTIMESTEP") != null) {
            if (request.getParameter("NOSTOP_WHEN_BELOW_MINTIMESTEP").equals("true")) {
                appInputGADGET.NOSTOP_WHEN_BELOW_MINTIMESTEP = true;
            }
        } else {
            appInputGADGET.NOSTOP_WHEN_BELOW_MINTIMESTEP = false;
        }

        if (request.getParameter("NOPMSTEPADJUSTMENT") != null) {
            if (request.getParameter("NOPMSTEPADJUSTMENT").equals("true")) {
                appInputGADGET.NOPMSTEPADJUSTMENT = true;
            }
        } else {
            appInputGADGET.NOPMSTEPADJUSTMENT = false;
        }


        if (request.getParameter("HAVE_HDF5") != null) {
            if (request.getParameter("HAVE_HDF5").equals("true")) {
                appInputGADGET.HAVE_HDF5 = true;
            }
        } else {
            appInputGADGET.HAVE_HDF5 = false;
        }


        if (request.getParameter("OUTPUTPOTENTIAL") != null) {
            if (request.getParameter("OUTPUTPOTENTIAL").equals("true")) {
                appInputGADGET.OUTPUTPOTENTIAL = true;
            }
        } else {
            appInputGADGET.OUTPUTPOTENTIAL = false;
        }

        if (request.getParameter("OUTPUTACCELERATION") != null) {
            if (request.getParameter("OUTPUTACCELERATION").equals("true")) {
                appInputGADGET.OUTPUTACCELERATION = true;
            }
        } else {
            appInputGADGET.OUTPUTACCELERATION = false;
        }

        if (request.getParameter("OUTPUTCHANGEOFENTROPY") != null) {
            if (request.getParameter("OUTPUTCHANGEOFENTROPY").equals("true")) {
                appInputGADGET.OUTPUTCHANGEOFENTROPY = true;
            }
        } else {
            appInputGADGET.OUTPUTCHANGEOFENTROPY = false;
        }


        if (request.getParameter("OUTPUTTIMESTEP") != null) {
            if (request.getParameter("OUTPUTTIMESTEP").equals("true")) {
                appInputGADGET.OUTPUTTIMESTEP = true;
            }
        } else {
            appInputGADGET.OUTPUTTIMESTEP = false;
        }

        if (request.getParameter("NOGRAVITY") != null) {
            if (request.getParameter("NOGRAVITY").equals("true")) {
                appInputGADGET.NOGRAVITY = true;
            }
        } else {
            appInputGADGET.NOGRAVITY = false;
        }

        if (request.getParameter("NOTREERND") != null) {
            if (request.getParameter("NOTREERND").equals("true")) {
                appInputGADGET.NOTREERND = true;
            }
        } else {
            appInputGADGET.NOTREERND = false;
        }


        if (request.getParameter("NOTYPEPREFIX_FFTW") != null) {
            if (request.getParameter("NOTYPEPREFIX_FFTW").equals("true")) {
                appInputGADGET.NOTYPEPREFIX_FFTW = true;
            }
        } else {
            appInputGADGET.NOTYPEPREFIX_FFTW = false;
        }

        if (request.getParameter("LONG_XYZ") != null) {
            if (request.getParameter("LONG_XYZ").equals("true")) {
                appInputGADGET.LONG_XYZ = true;
            }
        } else {
            appInputGADGET.LONG_XYZ = false;
        }

        if (request.getParameter("TWODIMS") != null) {
            if (request.getParameter("TWODIMS").equals("true")) {
                appInputGADGET.TWODIMS = true;
            }
        } else {
            appInputGADGET.TWODIMS = false;
        }

        if (request.getParameter("SPH_BND_PARTICLES") != null) {
            if (request.getParameter("SPH_BND_PARTICLES").equals("true")) {
                appInputGADGET.SPH_BND_PARTICLES = true;
            }
        } else {
            appInputGADGET.SPH_BND_PARTICLES = false;
        }


        if (request.getParameter("NOVISCOSITYLIMITER") != null) {
            if (request.getParameter("NOVISCOSITYLIMITER").equals("true")) {
                appInputGADGET.NOVISCOSITYLIMITER = true;
            }
        } else {
            appInputGADGET.NOVISCOSITYLIMITER = false;
        }

        if (request.getParameter("COMPUTE_POTENTIAL_ENERGY") != null) {

            appInputGADGET.COMPUTE_POTENTIAL_ENERGY = true;
        } else {
            appInputGADGET.COMPUTE_POTENTIAL_ENERGY = false;
        }



        if (request.getParameter("LONGIDS") != null) {
            if (request.getParameter("LONGIDS").equals("true")) {
                appInputGADGET.LONGIDS = true;
            }
        } else {
            appInputGADGET.LONGIDS = false;
        }

        if (request.getParameter("ISOTHERMAL") != null) {
            if (request.getParameter("ISOTHERMAL").equals("true")) {
                appInputGADGET.ISOTHERMAL = true;
            }
        } else {
            appInputGADGET.ISOTHERMAL = false;
        }

        if (request.getParameter("SELECTIVE_NO_GRAVITY") != null) {
            if (request.getParameter("SELECTIVE_NO_GRAVITY").equals("true")) {
                appInputGADGET.SELECTIVE_NO_GRAVITY = true;
            }
        } else {
            appInputGADGET.SELECTIVE_NO_GRAVITY = false;
        }

        if (request.getParameter("FORCETEST") != null) {
            appInputGADGET.FORCETEST = request.getParameter("FORCETEST");

        }

        if (request.getParameter("MAKEGLASS") != null) {
            if (request.getParameter("MAKEGLASS").equals("true")) {
                appInputGADGET.MAKEGLASS = true;
            }
        } else {
            appInputGADGET.MAKEGLASS = false;
        }




    } // getInputGADGET
    public void getInputFormGADGET_PARAM(ActionRequest request,App_InputGADGET_PARAM appInputGADGET_PARAM){
            // Retrieve from the input form the given application values



        /**
         * ****** RETRIVE INPUT GADGET PARAM*******
         */
        
         appInputGADGET_PARAM.OutputDir=(String) request.getParameter("OutputDir");
         appInputGADGET_PARAM.SnapshotFileBase=(String) request.getParameter("SnapshotFileBase");      
         appInputGADGET_PARAM.SnapFormat=(String) request.getParameter("SnapFormat");      
         appInputGADGET_PARAM.NumFilesPerSnapshot=(String) request.getParameter("NumFilesPerSnapshot");      
         appInputGADGET_PARAM.InitCondFile=(String) request.getParameter("InitCondFile");      
         appInputGADGET_PARAM.ICFormat=(String) request.getParameter("ICFormat");      
         appInputGADGET_PARAM.RestartFile=(String) request.getParameter("RestartFile");      
         appInputGADGET_PARAM.InfoFile=(String) request.getParameter("InfoFile");      
         appInputGADGET_PARAM.TimingsFile=(String) request.getParameter("TimingsFile");            
         appInputGADGET_PARAM.CpuFile=(String) request.getParameter("CpuFile");      
         appInputGADGET_PARAM.EnergyFile=(String) request.getParameter("EnergyFile");      
         appInputGADGET_PARAM.TimeLimitCPU=(String) request.getParameter("TimeLimitCPU");             
         appInputGADGET_PARAM.ResubmitCommand=(String) request.getParameter("ResubmitCommand");             
         appInputGADGET_PARAM.ResubmitOn=(String) request.getParameter("ResubmitOn");      
         appInputGADGET_PARAM.CpuTimeBetRestartFile=(String) request.getParameter("CpuTimeBetRestartFile");      
         appInputGADGET_PARAM.TimeBegin=(String) request.getParameter("TimeBegin");
         appInputGADGET_PARAM.TimeMax=(String) request.getParameter("TimeMax");      
         appInputGADGET_PARAM.BoxSize=(String) request.getParameter("BoxSize");      
         appInputGADGET_PARAM.PeriodicBoundariesOn=(String) request.getParameter("PeriodicBoundariesOn");      
         appInputGADGET_PARAM.ComovingIntegrationOn=(String) request.getParameter("ComovingIntegrationOn");              
         appInputGADGET_PARAM.HubbleParam=(String) request.getParameter("HubbleParam");      
         appInputGADGET_PARAM.Omega0=(String) request.getParameter("Omega0");      
         appInputGADGET_PARAM.OmegaLambda=(String) request.getParameter("OmegaLambda");      
         appInputGADGET_PARAM.OmegaBaryon=(String) request.getParameter("OmegaBaryon");      
        
         
        
    }

    public void createGADGET_PARAM(App_InputGADGET_PARAM appInputGADGET_PARAM){
         try {

            System.out.println("sono dentro param ");

            String content = ""
                    
                    + "\n"
                    + "OutputDir                " + appInputGADGET_PARAM.OutputDir + "\n"
                    + "SnapshotFileBase         " + appInputGADGET_PARAM.SnapshotFileBase + "\n"
                    + "SnapFormat               " + appInputGADGET_PARAM.SnapFormat + "\n"
                    + "NumFilesPerSnapshot      " + appInputGADGET_PARAM.NumFilesPerSnapshot + "\n"
                    + "InitCondFile             " + appInputGADGET_PARAM.InitCondFile + "\n"
                    + "ICFormat                 " + appInputGADGET_PARAM.ICFormat + "\n"
                    + "RestartFile              " + appInputGADGET_PARAM.RestartFile + "\n"
                    + "InfoFile                 " + appInputGADGET_PARAM.InfoFile + "\n"
                    + "TimingsFile              " + appInputGADGET_PARAM.TimingsFile + "\n"
                    + "CpuFile                  " + appInputGADGET_PARAM.CpuFile + "\n"
                    + "EnergyFile               " + appInputGADGET_PARAM.EnergyFile + "'\n"
                    + "TimeLimitCPU             " + appInputGADGET_PARAM.TimeLimitCPU + "\n"
                    + "ResubmitCommand          " + appInputGADGET_PARAM.ResubmitCommand + "\n"
                    + "ResubmitOn               " + appInputGADGET_PARAM.ResubmitOn + "\n"
                    + "CpuTimeBetRestartFile    " + appInputGADGET_PARAM.CpuTimeBetRestartFile + "\n"
                    + "TimeBegin                " + appInputGADGET_PARAM.TimeBegin + "\n"
                    + "TimeMax                  " + appInputGADGET_PARAM.TimeMax + "\n"
                    + "BoxSize                  " + appInputGADGET_PARAM.BoxSize + "\n"
                    + "PeriodicBoundariesOn     " + appInputGADGET_PARAM.PeriodicBoundariesOn + "\n"
                    + "ComovingIntegrationOn    " + appInputGADGET_PARAM.ComovingIntegrationOn + "\n"
                    + "HubbleParam              " + appInputGADGET_PARAM.HubbleParam + "\n"
                    + "Omega0                   " + appInputGADGET_PARAM.Omega0 + "\n"
                    + "OmegaLambda              " + appInputGADGET_PARAM.OmegaLambda + "\n"
                    + "OmegaBaryon              " + appInputGADGET_PARAM.OmegaBaryon + "\n"
                    + "BufferSize                5\n"
                    + "PartAllocFactor           1.1\n"
                    + "TreeAllocFactor           0.7\n" 
                    + "TypeOfOpeningCriterion    0\n"
                    + "ErrTolTheta               0.7\n"
                    + "ErrTolForceAcc            0.005\n"
                    + "MaxSizeTimestep           0.01\n"
                    + "MinSizeTimestep           0\n"
                    + "TypeOfTimestepCriterion   0\n"
                    + "ErrTolIntAccuracy         0.025\n"
                    + "TreeDomainUpdateFrequency 0.05\n"
                    + "MaxRMSDisplacementFac     0.25\n"
                    + "OutputListOn              0\n"
                    + "OutputListFilename        output times.txt\n"
                    + "TimeOfFirstSnapshot       0.047619048\n"
                    + "TimeBetSnapshot           1.0627825\n"
                    + "TimeBetStatistics         0.1\n"
                    + "NumFilesWrittenInParallel 16\n"
                    + "UnitVelocity_in_cm_per_s  1e5\n"
                    + "UnitLength_in_cm          3.085678e21\n"
                    + "UnitMass_in_g             1.989e43\n"
                    + "GravityConstantInternal   0\n"
                    + "DesNumNgb                 64\n"
                    + "MaxNumNgbDeviation        2\n"
                    + "ArtBulkViscCons           1.0\n"
                    + "CourantFac                0.15\n"
                    + "InitGasTemp               10000\n"
                    + "MinGasTemp                20\n"
                    + "MinGasHsmlFractional      0.1\n"
                    + "SofteningGas              0\n"
                    + "SofteningHalo             18\n"
                    + "SofteningDisk             90\n"
                    + "SofteningBulge            450\n"
                    + "SofteningStars            0\n"
                    + "SofteningBndry            0\n"
                    + "SofteningGasMaxPhys       0\n"
                    + "SofteningHaloMaxPhys      3\n"
                    + "SofteningDiskMaxPhys      15\n"
                    + "SofteningBulgeMaxPhys     75\n"
                    + "SofteningStarsMaxPhys     0\n"
                    + "SofteningBndryMaxPhys     0\n";


            // String inputSandbox=appServerPath+"WEB-INF/job/"+file;
            File file = new File(appServerPath + "/WEB-INF/job/gadget.param");


            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();

            System.out.println(content);
            System.out.println("param file done " + file.getAbsolutePath());


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void createGADGET_MAKEFILE(App_InputGADGET appInputGADGET) {


        //System.out.println("V1=>"+appInputGADGET.PERIODIC"V2=>"+appInputGADGET.UNEQUALSOFTENINGS+"V3=>"+appInputGADGET.PEANOHILBERT+"V4=>"+"V1=>"+"V1=>"+"V1=>"+"V1=>"+);
        try {
            String content = "";
            System.out.println("sono dentro createGADGET_MAKEFILE ");
            if (appInputGADGET.PERIODIC) {
                content += "OPT   +=  -DPERIODIC \n";
            }
            if (appInputGADGET.UNEQUALSOFTENINGS) {
                content += "OPT   +=  -DUNEQUALSOFTENINGS\n";
            }

            if (appInputGADGET.PEANOHILBERT) {
                content += "OPT   +=  -DPEANOHILBERT\n";
            };

            if (appInputGADGET.WALLCLOCK) {
                content += "OPT   +=  -DWALLCLOCK\n";
            }

            if (appInputGADGET.PMGRID) {
                content += "OPT   +=  -DPMGRID\n";
            }
            
             if (appInputGADGET.PLACEHIGHRESREGION!="") {
                content += "OPT   +=  -DPLACEHIGHRESREGION="+appInputGADGET.PLACEHIGHRESREGION+"\n";
            }

          

            if (appInputGADGET.ENLARGEREGION != "") {
                content += "OPT   +=  -DENLARGEREGIO=" + appInputGADGET.ENLARGEREGION + "\n";
            }


            if (appInputGADGET.ASMTH != "") {
                content += "OPT   +=  -DASMTH=" + appInputGADGET.ASMTH + "\n";
            }

            if (appInputGADGET.RCUT != "") {
                content += "OPT   +=  -DRECUT=" + appInputGADGET.RCUT + "\n";
            }


            if (appInputGADGET.DOUBLEPRECISION) {
                content += "OPT   +=  -DDOUBLEPRECISION\n";
            }

            if (appInputGADGET.DOUBLEPRECISION_FFTW) {
                content += "OPT   +=  -DDOUBLEPRECISION_FFTW\n";
            }

            if (appInputGADGET.SYNCHRONIZATION) {
                content += "OPT   +=  -DSYNCHRONIZATION\n";
            }

            if (appInputGADGET.FLEXSTEPS) {
                content += "OPT   +=  -DFLEXSTEPS\n";
            }

            if (appInputGADGET.PSEUDOSYMMETRIC) {
                content += "OPT   +=  -DPSEUDOSYMMETRIC\n";
            }

            if (appInputGADGET.NOSTOP_WHEN_BELOW_MINTIMESTEP) {
                content += "OPT   +=  -DNOSTOP_WHEN_BELOW_MINTIMESTEP\n";
            }

            if (appInputGADGET.NOPMSTEPADJUSTMENT) {
                content += "OPT   +=  -DNOPMSTEPADJUSTMENT\n";
            }

            if (appInputGADGET.HAVE_HDF5) {
                content += "OPT   +=  -DHAVE_HDF5\n";
            }

            if (appInputGADGET.OUTPUTPOTENTIAL) {
                content += "OPT   +=  -DOUTPUTPOTENTIAL\n";
            }

            if (appInputGADGET.OUTPUTACCELERATION) {
                content += "OPT   +=  -DOUTPUTACCELERATION\n";
            }

            if (appInputGADGET.OUTPUTCHANGEOFENTROPY) {
                content += "OPT   +=  -DOUTPUTCHANGEOFENTROPY\n";
            }

            if (appInputGADGET.OUTPUTTIMESTEP) {
                content += "OPT   +=  -DOUTPUTTIMESTEP\n";
            }

            if (appInputGADGET.NOGRAVITY) {
                content += "OPT   +=  -DNOGRAVITY\n";
            }

            if (appInputGADGET.NOTREERND) {
                content += "OPT   +=  -DNOTREERND\n";
            }

            if (appInputGADGET.NOTYPEPREFIX_FFTW) {
                content += "OPT   +=  -DNOTYPEPREFIX_FFTW\n";
            }

            if (appInputGADGET.LONG_XYZ) {
                content += "OPT   +=  -DLONG_XYZ\n";
            }

            if (appInputGADGET.TWODIMS) {
                content += "OPT   +=  -DTWODIMS\n";
            }

            if (appInputGADGET.SPH_BND_PARTICLES) {
                content += "OPT   +=  -DSPH_BND_PARTICLES\n";
            }

            if (appInputGADGET.NOVISCOSITYLIMITER) {
                content += "OPT   +=  -DNOVISCOSITYLIMITER\n";
            }

            if (appInputGADGET.COMPUTE_POTENTIAL_ENERGY) {
                content += "OPT   +=  -DCOMPUTE_POTENTIAL_ENERGY\n";
            }

            if (appInputGADGET.LONGIDS) {
                content += "OPT   +=  -DLONGIDS\n";
            }
             if (appInputGADGET.ISOTHERMAL) {
                content += "OPT   +=  -DISOTHERMAL\n";
            }
             
              if (appInputGADGET.SELECTIVE_NO_GRAVITY) {
                content += "OPT   +=  -DSELECTIVE_NO_GRAVITY\n";
            }
              
             if (appInputGADGET.FORCETEST != "") {
                content += "OPT   +=  -DFORCETEST=" + appInputGADGET.FORCETEST + "\n";
            } 
              
               if (appInputGADGET.MAKEGLASS) {
                content += "OPT   +=  -DMAKEGLASS\n";
            }


            // String inputSandbox=appServerPath+"WEB-INF/job/"+file;
            File file = new File(appServerPath + "/WEB-INF/job/gadget.makefile");


            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();


            System.out.println("MAKEFILE Done " + file.getAbsolutePath());
             System.out.println(content);


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void createMUSICconfigFile(App_Input appInput) {
        try {

            System.out.println("sono dentro createMUSICconf ");

            String content = ""
                    //                    + "OPT   +=  -DPERIODIC "
                    + "[setup]\n"
                    + "boxlength     = " + appInput.boxlength + "\n"
                    + "zstart        = " + appInput.zstart + "\n"
                    + "levelmin      = " + appInput.levelmin + "\n"
                    + "levelmin_TF   = " + appInput.levelmin_TF + "\n"
                    + "levelmax      = " + appInput.levelmax + "\n"
                    + "padding       = " + appInput.padding + "\n"
                    + "overlap       = " + appInput.overlap + "\n"
                    + "ref_center    = " + appInput.ref_center + "\n"
                    + "ref_extent    = " + appInput.ref_extent + "\n"
                    + "ref_offset    = " + appInput.ref_offset + "\n"
                    + "align_top     = " + appInput.align_top + "'\n"
                    + "baryons       = " + appInput.baryons + "\n"
                    + "use_2LPT      = " + appInput.use_2LPT + "\n"
                    + "periodic_TF   = " + appInput.periodic_TF + "\n"
                    + "\n\n\n[cosmology]\n"
                    + "omega_m     = " + appInput.omega_m + "\n"
                    + "omega_L     = " + appInput.omega_L + "\n"
                    + "omega_b     = " + appInput.omega_b + "\n"
                    + "H0          = " + appInput.H0 + "\n"
                    + "sigma_8     = " + appInput.sigma_8 + "\n"
                    + "nspec       = " + appInput.nspec + "\n"
                    + "transfer    = " + appInput.transfer + "\n"
                    + "\n\n\n[random]\n"
                    + "seed7      = " + appInput.seed7 + "\n"
                    + "seed8      = " + appInput.seed8 + "\n"
                    + "seed9      = " + appInput.seed9 + "\n"
                    + "seed10     = " + appInput.seed10 + "\n"
                    + "seed11     = " + appInput.seed11 + "\n"
                    + "seed12     = " + appInput.seed12 + "\n"
                    + "transfer   = " + appInput.transfer + "\n"
                    + "\n\n\n[output]"
                    + "##generic MUSIC data format (used for testing)\n"
                    + "##requires HDF5 installation and HDF5 enabled in Makefile \n"
                    + "#format         = generic \n"
                    + "#filename       = debug.hdf5 \n\n"
                    + "##ENZO - also outputs the settings for the parameter file \n"
                    + "##requires HDF5 installation and HDF5 enabled in Makefile \n"
                    + "#format         = enzo \n"
                    + "#filename       = ic.enzo \n\n"
                    + "##Gadget-2 (type=1: high-res particles, type=5: rest) \n"
                    + "#format         = gadget2 \n"
                    + "#filename       = ics_gadget.dat \n\n"
                    + "##Grafic2 compatible format for use with RAMSES \n"
                    + "##option 'ramses_nml'=yes writes out a startup nml file \n"
                    + "#format         = grafic2 \n"
                    + "#filename       = ics_ramses \n"
                    + "#ramses_nml     = yes \n\n"
                    + "##TIPSY compatible with PKDgrav and Gasoline \n"
                    + "#format         = tipsy \n"
                    + "#filename       = ics_tipsy.dat \n\n"
                    + "## NYX compatible output format \n"
                    + "##requires boxlib installation and boxlib enabled in Makefile \n"
                    + "#format         = nyx \n"
                    + "#filename       = init \n"
                    + "\n\n\n[poisson]\n"
                    + "fft_fine        = " + appInput.fft_fine + "\n"
                    + "accuracy        = " + appInput.accuracy + "\n"
                    + "pre_smooth      = " + appInput.pre_smooth + "\n"
                    + "post_smooth     = " + appInput.post_smooth + "\n"
                    + "smoother        = " + appInput.smoother + "\n"
                    + "laplace_order   = " + appInput.laplace_order + "\n"
                    + "grad_order      = " + appInput.grad_order + "\n";


            // String inputSandbox=appServerPath+"WEB-INF/job/"+file;
            File file = new File(appServerPath + "/WEB-INF/job/music.conf");


            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();


            System.out.println("FileDone " + file.getAbsolutePath());


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
} // GADGET_portlet 
