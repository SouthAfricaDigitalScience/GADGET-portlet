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
        , ACTION_SUBMIT_MUSIC   // Called after the user press the submit button    
    }

    private enum Views {

        VIEW_INPUT // View containing application input field
        , VIEW_SUBMIT_MUSIC // View reporting input value    
        , VIEW_NO_ACTION
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

    class App_InputGADGET{
            boolean PERIODIC;
        boolean UNEQUALSOFTENINGS;
        boolean PEANOHILBERT;
        boolean WALLCLOCK;
        boolean PMGR;
        String PLACEHIGHRESREGION;
        String ENLARGEREGION;
        String ASMT;
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
        boolean FORCETEST;
        boolean MAKEGLASS;
        
        public App_InputGADGET(){
            
            PERIODIC=UNEQUALSOFTENINGS=PEANOHILBERT=WALLCLOCK=PMGR=DOUBLEPRECISION=DOUBLEPRECISION_FFTW=SYNCHRONIZATION=FLEXSTEPS=PSEUDOSYMMETRIC=NOSTOP_WHEN_BELOW_MINTIMESTEP=NOPMSTEPADJUSTMENT=HAVE_HDF5=OUTPUTPOTENTIAL=OUTPUTACCELERATION=OUTPUTCHANGEOFENTROPY=OUTPUTTIMESTEP=NOGRAVITY=NOTREERND=NOTYPEPREFIX_FFTW=LONG_XYZ=TWODIMS=SPH_BND_PARTICLES=NOVISCOSITYLIMITER=COMPUTE_POTENTIAL_ENERGY=LONGIDS=ISOTHERMAL=SELECTIVE_NO_GRAVITY=FORCETEST=MAKEGLASS=false;
            PLACEHIGHRESREGION=ENLARGEREGION=ASMT=RCUT="";
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
                System.out.println("VIEW_SUBMIT Selected ...");

                String inputValue = request.getParameter("inputValue");

               // request.setAttribute("inputValue", inputValue);
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/inputGadget.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_NO_ACTION: {
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
         * ****** RETRIVE INPUT GADGET VALUES*******
         */
        appInputGADGET.PERIODIC = (Boolean) request.getParameter("PERIODIC");
        appInputGADGET.UNEQUALSOFTENINGS = (String) request.getParameter("UNEQUALSOFTENINGS");
        appInputGADGET.PEANOHILBERT = (String) request.getParameter("PEANOHILBERT");
        appInputGADGET.WALLCLOCK = (String) request.getParameter("WALLCLOCK");
        appInputGADGET.PMGR = (String) request.getParameter("PMGR");
        appInputGADGET.PLACEHIGHRESREGION = (String) request.getParameter("PLACEHIGHRESREGION");
        appInputGADGET.ENLARGEREGION = (String) request.getParameter("ENLARGEREGION");
        appInputGADGET.ASMT = (String) request.getParameter("ASMT");
        appInputGADGET.RCUT = (String) request.getParameter("RCUT");
        appInputGADGET.DOUBLEPRECISION = (String) request.getParameter("DOUBLEPRECISION");
        appInputGADGET.DOUBLEPRECISION_FFTW = (String) request.getParameter("DOUBLEPRECISION_FFTW");
        appInputGADGET.PMGR = (String) request.getParameter("PMGR");
        appInputGADGET.SYNCHRONIZATION = (String) request.getParameter("SYNCHRONIZATION");
        appInputGADGET.FLEXSTEPS = (String) request.getParameter("FLEXSTEPS");
        appInputGADGET.PSEUDOSYMMETRIC = (String) request.getParameter("PSEUDOSYMMETRIC");
        appInputGADGET.NOSTOP_WHEN_BELOW_MINTIMESTEP = (String) request.getParameter("NOSTOP_WHEN_BELOW_MINTIMESTEP");
        appInputGADGET.NOPMSTEPADJUSTMENT = (String) request.getParameter("NOPMSTEPADJUSTMENT");
        appInputGADGET.HAVE_HDF5 = (String) request.getParameter("HAVE_HDF5");
        appInputGADGET.OUTPUTPOTENTIAL = (String) request.getParameter("OUTPUTPOTENTIAL");
        appInputGADGET.OUTPUTACCELERATION = (String) request.getParameter("OUTPUTACCELERATION");
        appInputGADGET.OUTPUTCHANGEOFENTROPY = (String) request.getParameter("OUTPUTCHANGEOFENTROPY");
        appInputGADGET.OUTPUTTIMESTEP = (String) request.getParameter("OUTPUTTIMESTEP");
        appInputGADGET.NOGRAVITY = (String) request.getParameter("NOGRAVITY");
        appInputGADGET.NOTREERND = (String) request.getParameter("NOTREERND");
        appInputGADGET.NOTYPEPREFIX_FFTW = (String) request.getParameter("NOTYPEPREFIX_FFTW");
        appInputGADGET.LONG_XYZ = (String) request.getParameter("LONG_XYZ");
        appInputGADGET.TWODIMS = (String) request.getParameter("TWODIMS");
        appInputGADGET.SPH_BND_PARTICLES = (String) request.getParameter("SPH_BND_PARTICLES");
        appInputGADGET.NOVISCOSITYLIMITER = (String) request.getParameter("NOVISCOSITYLIMITER");
        appInputGADGET.COMPUTE_POTENTIAL_ENERGY = (String) request.getParameter("COMPUTE_POTENTIAL_ENERGY");
        appInputGADGET.LONGIDS = (String) request.getParameter("LONGIDS");
        appInputGADGET.ISOTHERMAL = (String) request.getParameter("ISOTHERMAL");
        appInputGADGET.SELECTIVE_NO_GRAVITY = (String) request.getParameter("SELECTIVE_NO_GRAVITY");
        appInputGADGET.FORCETEST = (String) request.getParameter("FORCETEST");
        appInputGADGET.MAKEGLASS = (String) request.getParameter("MAKEGLASS");



      
    } // getInputForm 

    
    public void createMUSICconfigFile(App_Input appInput) {


//        String inputSandbox=appServerPath+"WEB-INF/job/"        //
//                               +appPreferences.getPilotScript()     // pilot script
//                               +","+appInput.inputSandbox_inputFile // input file
//                               ;




        try {

            System.out.println("sono dentro createGADGETMakefile ");

            String content = ""
                    if(PERIODIC)
                    + "OPT   +=  -DPERIODIC "
                    
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
