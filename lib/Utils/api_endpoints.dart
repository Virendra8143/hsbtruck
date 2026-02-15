class ApiEndpoints {
  static const String baseUrl = "https://hsb.bugsbon.com/api";

  // Authentication Endpoints
  static const String login = "$baseUrl/login";
  static const String Managerlogin = "$baseUrl/manager-login";

  // Branch Endpoints
  static const String createBranch = "$baseUrl/create-branch";
  static const String getBranchList = "$baseUrl/get-branch-list";
  static const String updateBranchList = "$baseUrl/update-branch";
  static const String getBranch = "$baseUrl/get-branch/id";
  static const String branchSearchList = "$baseUrl/get-branch-list/searchvalue";
  static const String updateBranchStatus = "$baseUrl/update-admin-status/id/status"; //active inactive

  //Admin Endpoints
  static const String createAdmin= "$baseUrl/create-admin";
  static const String getAdminList = "$baseUrl/get-admin-list";
  static const String updateAdmin = "$baseUrl/update-admin";
  static const String getAdmin = "$baseUrl/get-admin/1";   //get single detail
  static const String adminSearchList = "$baseUrl/get-admin-list/search";  //search within list
  static const String updateAdminStatus = "$baseUrl/update-admin-status/id/status";  //active/inactive

  //Trash Endpoints
  static const String trashList = "$baseUrl/get-trash-list";
  static const String restoreItem = "$baseUrl/restore-item/"; // id/type

  //Staff Endpoints
  static const String updateStaffStatus = "$baseUrl/update-staff-status/"; // id/status (append id/status)
  static const String updateStaff = "$baseUrl/update-staff"; // POST body contains id
  static const String getStaffDetail = "$baseUrl/get-staff/"; //id
  static const String getStaffList = "$baseUrl/get-staff-list"; // append /type/search when needed
  static const String createStaff = "$baseUrl/add-staff";
  static const String deleteStaff = "$baseUrl/delete-staff/"; //id

  //Product Endpoints
  static const String createProductName = "$baseUrl/create-product-name";
  static const String getProductName = "$baseUrl/get-product-name";
  static const String getProductList = "$baseUrl/get-product-list";
  static const String getProductDetail = "$baseUrl/get-product/"; //id
  static const String addUpdateProduct = "$baseUrl/add-update-product";
  static const String deleteProduct = "$baseUrl/delete-product/"; //id
  static const String getProductCount = "$baseUrl/product-count";
  static const String productGraph = "$baseUrl/product-graph";
  static const String getLowStockProductList = "$baseUrl/get-low-stock-product-list";

  //Machine Endpoints
  static const String addMachine = "$baseUrl/add-machine";
  static const String getMachineList = "$baseUrl/get-machine-list";
  static const String getMachineDetail = "$baseUrl/get-machine/"; //id
  static const String updateMachine = "$baseUrl/update-machine";
  static const String deleteMachine = "$baseUrl/delete-machine/"; //id
  static const String updateMachineStatus = "$baseUrl/update-machine-status"; // append /id/status
  static const String getMachineListSearch = "$baseUrl/get-machine-list/search";

  //Scheme Endpoints
  static const String createSchemeName = "$baseUrl/create-scheme-name";
  static const String getSchemeName = "$baseUrl/get-scheme-name";
  static const String getSchemeList = "$baseUrl/get-scheme-list";
  static const String getSchemeDetail = "$baseUrl/get-scheme/"; //id
  static const String addUpdateScheme = "$baseUrl/add-update-scheme";
  static const String deleteScheme = "$baseUrl/delete-scheme/"; //id
  static const String updateSchemeStatus = "$baseUrl/update-scheme-status"; // append /id/status
  static const String getSchemeListSearch = "$baseUrl/get-scheme-list/search";
  static const String getVehicleTypes = "$baseUrl/get-vehicle-types";
  static const String getProductTypes = "$baseUrl/get-product-types";

  //Tanker Endpoints
  static const String getTankerList = "$baseUrl/get-tanker-list";
  static const String getTankerDetail = "$baseUrl/get-tanker-detail/"; // id
  static const String updateTanker = "$baseUrl/update-tanker";
  static const String deleteTanker = "$baseUrl/delete-tanker/"; //id
  static const String getTankerTypes = "$baseUrl/get-tanker-types";
  static const String getTotalTanker = "$baseUrl/get-total-tanker";
  static const String addTanker = "$baseUrl/add-tanker";
  static const String addCrewMember = "$baseUrl/add-crew-member";

  //Customer Endpoints
  static const String addCreditCustomer = "$baseUrl/add-credit-customer";
  static const String updateCreditCustomer = "$baseUrl/update-credit-customer";
  static const String getCreditCustomerDetail = "$baseUrl/get-credit-customer/"; // id
  static const String getCreditCustomerList = "$baseUrl/get-credit-customer-list"; // append /search
  static const String updateCreditCustomerStatus = "$baseUrl/update-credit-customer-status"; // append /id/status
  static const String creditCustomerProductList = "$baseUrl/credit-customer-product-list/"; // id

  //Sales and Analytics Endpoints
  static const String getSalesData = "$baseUrl/get-sales-data";
  static const String exportReports = "$baseUrl/export-reports";
  static const String getSalesAnalytics = "$baseUrl/get-sales-analytics";

  //Authentication Endpoints
  static const String adminLogin = "$baseUrl/admin-login";
  static const String logout = "$baseUrl/logout";

  // Tasks
  static const String addTask = "$baseUrl/add-task";
}

