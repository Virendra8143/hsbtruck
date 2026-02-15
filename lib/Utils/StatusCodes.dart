// Status codes for the application
// These are used for item status management across the app

class StatusCodes {
  static const String inactive = '0';
  static const String active = '1';
  static const String trash = '2';
  static const String delete = '9';

  // Helper method to get status code by name
  static String? getStatusCode(String action) {
    switch (action.toLowerCase()) {
      case 'inactive':
      case 'deactivate':
        return inactive;
      case 'active':
      case 'activate':
        return active;
      case 'trash':
        return trash;
      case 'delete':
        return delete;
      default:
        return null;
    }
  }

  // Helper method to get status name by code
  static String getStatusName(String code) {
    switch (code) {
      case '0':
        return 'Inactive';
      case '1':
        return 'Active';
      case '2':
        return 'Trash';
      case '9':
        return 'Deleted';
      default:
        return 'Unknown';
    }
  }

  // Helper method to check if status is active
  static bool isActive(String status) {
    return status == active;
  }

  // Helper method to check if status is inactive
  static bool isInactive(String status) {
    return status == inactive;
  }

  // Helper method to check if status is trash
  static bool isTrash(String status) {
    return status == trash;
  }

  // Helper method to check if status is deleted
  static bool isDeleted(String status) {
    return status == delete;
  }
}


