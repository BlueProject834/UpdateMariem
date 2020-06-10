class Legend {

  String legend;





  Legend(

      this.legend,

      );



  Map<String, dynamic> toJson() => {

    'Legende': legend,

  };

}