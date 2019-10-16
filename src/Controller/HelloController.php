<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HelloController extends AbstractController
{

    /**
     * @Route("/hello/{number}", name="hello_number", requirements={"number"="\d+"})
     */
    public function number($number)
    {

        return $this->render('hello/number.html.twig', array(
            'number' => $number,
            'admin' => 'Renaud',
        ));
    }


    /**
         * @Route("/hello/world", name="hello_world")
     */
    public function hello()
    {
        return $this->render('hello/world.html.twig', array(
        ));
    }

    /**
     * @Route("/hello/{name}", name="hello_name")
     */
    public function name($name)
    {
        return $this->render('hello/name.html.twig', array(
            'name' => $name,
        ));
    }




}
