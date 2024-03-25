
class MenuModel{
  final String assets;
  final String label;

  MenuModel({
    required this.assets,
    required this.label
  });

  static List<MenuModel> getMenu(){
    return [
      MenuModel(
        assets: 'assets/illustration/holiday.png', 
        label: 'Leave'
      ),
      MenuModel(
        assets: 'assets/illustration/calendar.png', 
        label: 'Swap Schedule'
      ),
      MenuModel(
        assets: 'assets/illustration/timer.png', 
        label: 'Overtime'
      ),
      MenuModel(
        assets: 'assets/illustration/agreement.png', 
        label: 'Permissions'
      ),
      MenuModel(
        assets: 'assets/illustration/form.png', 
        label: 'Feedback'
      ),
      MenuModel(
        assets: 'assets/illustration/documents.png', 
        label: 'My Archive'
      ),
      // MenuModel(
      //   assets: 'assets/illustration/bank_building.png', 
      //   label: 'Koperasi'
      // ),
      MenuModel(
        assets: 'assets/illustration/system_report.png', 
        label: 'Report'
      ),
      MenuModel(
        assets: 'assets/illustration/training.png', 
        label: 'Events'
      ),
    ];
  }
}