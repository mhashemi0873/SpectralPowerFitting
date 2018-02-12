function [ endpt,Fitness] = HJ (f, startpt, rho, itermax )


 nvars=size(startpt,2);
 eps = 1.0E-08;

  
    newx = startpt;
    xbefore = startpt;
 

  for i = 1 : nvars
    if ( startpt(i) == 0.0 )
      delta(i) = rho;
    else
      delta(i) = rho * abs ( startpt(i) );
    end
  end

  funevals = 0;
  steplength = rho;
  iters = 0;
  fbefore = feval (f, newx );
  funevals = funevals + 1;
  newf = fbefore;


  for  iters=1:itermax  

     Fitness(iters)=fbefore;

%  Find best new point, one coordinate at a time.

    newx = xbefore;
    
     [ newf, newx, funevals ] = bestnearby ( delta, newx, fbefore, nvars, f, funevals );

%  If we made some improvements, pursue that direction.
    
    keep = 1;
  
    while ( newf < fbefore & keep == 1 )
   
              for i = 1 : nvars

               %  Arrange the sign of DELTA.

                if ( newx(i) <= xbefore(i) )
                  delta(i) = - abs ( delta(i) );
                else
                  delta(i) = abs ( delta(i) );
                end

              %  Now, move further in this direction.

                tmp = xbefore(i);
                xbefore(i) = newx(i);
                newx(i) = newx(i) + newx(i) - tmp;
              end

      fbefore = newf;
      [ newf, newx, funevals ] = bestnearby ( delta, newx, fbefore, nvars, f, funevals );
    
  
%  If the further (optimistic) move was bad...

      if ( fbefore <= newf )
        break;
      end
      
              
%  Make sure that the differences between the new and the old points
%  are due to actual displacements; beware of roundoff errors that
%  might cause NEWF < FBEFORE.

      keep = 0;

      for i = 1 : nvars
        if ( 0.5 * abs ( delta(i) ) < abs ( newx(i) - xbefore(i) ) )
          keep = 1;
          break
        end
      end

    end

    
    if ( eps <= steplength & fbefore <= newf )
      steplength = steplength * rho;
      for i = 1 : nvars
        delta(i) = delta(i) * rho;
      end
    end



  end

 
  
    endpt = xbefore;
  

  
end
