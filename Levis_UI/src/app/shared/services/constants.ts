
export class Constants {
    public static get HOME_URL(): string { return "http://10.0.0.71:8000/api/"; };
    // public static get HOME_URL(): string { return "https://met-app-backend.cartesianconsulting.com/api/"; };
// 
    public static get LOGIN_URL(): string { return Constants.HOME_URL+"accounts/login/"; };
    public static get LOGOUT_URL(): string { return Constants.HOME_URL+"accounts/logout/"; };

    //GENOME
    public static get GENOME(): string { return Constants.HOME_URL+"repo_report/"; };
    public static get CLUSTER(): string { return Constants.HOME_URL+"genome/analysis_cluster/"; };
    public static get DIMENSION(): string { return Constants.HOME_URL+"genome/analysis_dimensions/"; };
    public static get CLISTER_DIMENSION_MAPPING(): string { return Constants.HOME_URL+"genome/analysis_usr_clstr_dim/"; };
    public static get CUSTOMER_SEGMENT_JOURNEY():string { return Constants.HOME_URL+"genome/analysis_journey/"; };

}