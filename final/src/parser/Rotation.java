import java.util.Scanner;

public class Rotation {
    public Rotation(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob;
		float angle;
		try{
			prob = s.nextFloat();
			s.next();
			angle = s.nextFloat();
			if(prob > 1 || s.hasNext())
				throw new Exception();
		} 
		finally{
			s.close();
		}
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __rotation(tmp,%s);\n", prob, angle);
		return code;
	}
}
