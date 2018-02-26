function LeapYear(yr)
{
/* Is it a leap year?
   1.Years divisible by 4 are leap years, but
   2.Years divisible by 100 are not leap years, but
   3.Years divisible by 400 are leap years. */

if (((yr % 4 == 0) && yr % 100 != 0) || yr % 400 == 0)
   return true;
else
   return false;
}

function IsDate(InString, InName, errors)
{
/* Note: Date must be in the format MM/DD/YYYY */

/* Allow empty fields as dates. */

   if (InString.value.length >0)
   {

      Slashes   = 0;
      Month     = 0;
      Day       = 0;
      Year      = 0;
      RefString = "01234567890/";

      for (i=0; i<InString.value.length; i++)
      {
         TempChar = InString.value.substring(i, i +1);

         /* Invalid character? */

         if (RefString.indexOf(TempChar,0) == -1) { errors += '- ' + InName + ' Date. Format must be: MM/DD/YYYY.\n'; return (errors); }

         /* Must have two slashes */

         if ( TempChar == "/" ) { Slashes++; }

      } /* end for */

      if ( Slashes != 2 ) { errors += '- ' + InName + ' Date. Format must be: MM/DD/YYYY.\n'; return (errors); }


      /* Parse out the date pieces */

      i =  0;
      x = "";

      /* Month */

      while ((InString.value.charAt(i) != "/") && (i <= InString.value.length))
      {
        x = x +  InString.value.charAt(i);
        i++;
      }
      Month = Month + x;  // Rely on implicit conversion of char string x to a number

      if (( Month < 1 ) || ( Month > 12 )) { errors += '- ' + InName + ' Date. Month must be between 1 and 12\n'; return (errors); }

      /* Day */

      i++; // Skip the slash
      x = "";
      while ((InString.value.charAt(i) != "/") && (i <= InString.value.length))
      {
        x = x +  InString.value.charAt(i);
        i++;
      }
      Day = Day + x;

      if (( Day < 1 ) || ( Day > 31 )) { errors += '- ' + InName + ' Date. Day must be between 1 and 31\n'; return (errors); }

      /* Year */

      i++;
      x = "";
      while ((InString.value.charAt(i) != "/") && (i <= InString.value.length))
      {
        x = x +  InString.value.charAt(i);
        i++;
      }
      Year = Year + x;

      if (( Year < 1000 ) || ( Year > 9999 )) { errors += '- ' + InName + ' Date. Year must be between 1000 and 9999.\n'; return (errors); }

      /* Check Day a bit more closely */

      if (( Month == 4 || Month == 6 || Month == 9 || Month == 11 ) && ( Day > 30 ))
      {
         errors += '- ' + InName + ' Date. Month ' + Month + ' can not have more than 30 days\n'; return ( errors );
      }

      if ( Month == 2)
      /* Check leap year */
      {
         /* Is it a leap year?
            1.Years divisible by 4 are leap years, but
            2.Years divisible by 100 are not leap years, but
            3.Years divisible by 400 are leap years. */

         if ( LeapYear(Year) )
         {
            if ( Day > 29 ) { errors += '- ' + InName + ' Date. February can not have more than 29 days in ' + Year + '.\n'; return ( errors ); }
         }
         else
         {
            if ( Day > 28 ) { errors += '- ' + InName + ' Date. February can not have more than 28 days in ' + Year + '.\n'; return ( errors ); }
         }

      }
   }
   return ( errors );
}