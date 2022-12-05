class JobDetails{
   final String job_id;
   final String job_tittle;
   final String job_descriptions;
   final String min_salary;
   final String max_salary;

   JobDetails({
     required  this.job_id,
     required  this.job_tittle,
     required  this.job_descriptions,
     required  this.min_salary,
     required  this.max_salary,
  });

   // factory JobDetails.fromJSON(Map<String, dynamic> json){
   //   return JobDetails(
   //       job_id: json["job_id"],
   //       job_tittle: json["job_tittle"],
   //       job_descriptions: json["job_descriptions"],
   //       min_salary: json["min_salary"],
   //       max_salary: json["max_salary"]
   //   );
   // }

}
