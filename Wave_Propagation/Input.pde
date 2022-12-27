import javax.swing.*;

String prompt(String s)
{
   println(s);
   String entry = JOptionPane.showInputDialog(s);
   if (entry == null)
      return null;
   println(entry);
   return entry;
}

String getString(String s)
{
   return prompt(s);
}

int getInt(String s)
{
   return Integer.parseInt(getString(s));
}

long getLong(String s)
{
   return Long.parseLong(getString(s));
}

float getFloat(String s)
{
   return Float.parseFloat(getString(s));
}

double getDouble(String s)
{
   return Double.parseDouble(getString(s));
}

char getChar(String s)
{
   String entry = prompt(s);
   if (entry.length() >= 1)
      return entry.charAt(0);
   else
      return '\n';
}
