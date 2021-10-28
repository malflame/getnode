(defun intsCir(point1 point2 pointr r1 r2 / point3)
  (setq d (distance point1 point2)) ; distance between points
  (setq x1 (nth 0 point1); execute
	y1 (nth 1 point1); coordinates
	x2 (nth 0 point2); from
	y2 (nth 1 point2); points
	)
  (setq a (/ (+ (- (expt r2 2) (expt r1 2)) (expt d 2)) (* d 2))); find distance on line(point1-point2) between "POINT2" and point, which intersect circle2
  (setq b (- d a)); find distance on line(point1-point2) between "POINT1" and point, which intersect circle1
  (setq x0 (+ (* (/ b d) (- x2 x1)) x1 )  ;// find coordinates
	y0 (+ (* (/ b d) (- y2 y1)) y1 )) ;// for POINT0
  (setq h (sqrt (- (expt r2 2) (expt a 2)))); find distance between POINT1 and POINT0
  (setq x3 (+ x0 (* (/ (- y2 y1) d) h))
	y3 (- y0 (* (/ (- x2 x1) d) h))
	x4 (- x0 (* (/ (- y2 y1) d) h))
	y4 (+ y0 (* (/ (- x2 x1) d) h)))
  
  (if (< (distance (list x3 y3) pointr) (distance (list x4 y4) pointr))
    (setq point3 (list x3 y3)
	  point3 (list x4 y4))
    )
  (setq le (entmakex '((0 . "POINT")
		       (8 . "0")
		       (10 0.0 0.0 0.0)
		       (62 . 5) )
		     )
	)
  (setq ob (entget le))
  (setq ob (subst (list 10 (nth 0 point3) (nth 1 point3) 0.0) (assoc 10 ob) ob))
  (entmod ob) (entupd le)
  )

(defun C:getNode(/)
  (setq point1 (entget (car (entsel "\nВыберите точку 1:"))))
  (while point1
    (setq point1 (cdr (assoc 10 point1)))
    (setq r1s (entget (car (entsel "\nВыберите расстояние:"))))
    (setq r1 (atof (cdr (assoc 1 r1s))))
    (setq point2 (entget (car (entsel "\nВыберите точку 2:"))))
    (setq point2 (cdr (assoc 10 point2)))
    (setq r2s (entget (car (entsel "\nВыберите расстояние:"))))
    (setq r2 (atof (cdr (assoc 1 r2s))))
    (setq pointr (getpoint point2 "\nВыбрать направление:"))
    (setq pointr (list (nth 0 pointr) (nth 1 pointr)))
    (print (intsCir point1 point2 pointr r1 r2))
    (setq point1 (entget (car (entsel "\nВыберите точку 1:"))))
    )
  )